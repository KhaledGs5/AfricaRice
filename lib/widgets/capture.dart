import 'dart:io';
import 'dart:typed_data';
import 'package:africa_rice/data/database/app_database.dart';
import 'package:africa_rice/data/services/rice_quality_model.dart';
import 'package:africa_rice/data/services/user_session.dart';
import 'package:africa_rice/widgets/results_screen.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:geolocator/geolocator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class Capture extends StatefulWidget {
  const Capture({super.key});

  @override
  State<Capture> createState() => _CaptureState();
}

class _CaptureState extends State<Capture> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;
  String? _validationWarning;
  bool _showGuidance = true;
  bool _enableGPS = false;
  Position? _currentPosition;
  late final AppDatabase _database;

  @override
  void initState() {
    super.initState();
    _database = AppDatabase();
    _loadGPSSetting();
  }

  @override
  void dispose() {
    _database.close();
    super.dispose();
  }

  Future<void> _loadGPSSetting() async {
    // Load GPS preference from shared preferences if needed
    // For now, default to false
  }

  Future<void> _requestLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location services are disabled. Please enable them in settings.')),
      );
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permission denied')),
        );
        setState(() {
          _enableGPS = false;
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Location permissions are permanently denied. Please enable them in app settings.'),
        ),
      );
      setState(() {
        _enableGPS = false;
      });
      return;
    }

    // Get current position
    try {
      final position = await Geolocator.getCurrentPosition();
      setState(() {
        _currentPosition = position;
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to get location: $e')),
      );
    }
  }

  Future<void> _processAndSaveImage() async {
    if (_selectedImage == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Get current user ID
      final userId = await UserSession.getUserId();
      if (userId == null) {
        throw Exception('User not logged in');
      }

      // Copy image to app directory
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = 'scan_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final savedImagePath = path.join(appDir.path, 'scans', fileName);
      
      // Create scans directory if it doesn't exist
      final scansDir = Directory(path.join(appDir.path, 'scans'));
      if (!await scansDir.exists()) {
        await scansDir.create(recursive: true);
      }
      
      // Copy the image
      await _selectedImage!.copy(savedImagePath);

      // Process image with AI model
      final metrics = await RiceQualityModel.analyzeImage(savedImagePath);

      // Save to database
      final scanId = await _database.insertScan(
        ScansCompanion(
          userId: drift.Value(userId),
          imagePath: drift.Value(savedImagePath),
          scanDate: drift.Value(DateTime.now()),
          latitude: _currentPosition != null ? drift.Value(_currentPosition!.latitude) : const drift.Value.absent(),
          longitude: _currentPosition != null ? drift.Value(_currentPosition!.longitude) : const drift.Value.absent(),
          totalGrains: drift.Value(metrics.totalGrains),
          brokenGrains: drift.Value(metrics.brokenGrains),
          longGrains: drift.Value(metrics.longGrains),
          mediumGrains: drift.Value(metrics.mediumGrains),
          shortGrains: drift.Value(metrics.shortGrains),
          blackGrains: drift.Value(metrics.blackGrains),
          chalkyGrains: drift.Value(metrics.chalkyGrains),
          redGrains: drift.Value(metrics.redGrains),
          yellowGrains: drift.Value(metrics.yellowGrains),
          greenGrains: drift.Value(metrics.greenGrains),
          avgLength: drift.Value(metrics.avgLength),
          avgWidth: drift.Value(metrics.avgWidth),
          avgLWR: drift.Value(metrics.avgLWR),
          cielabL: drift.Value(metrics.cielabL),
          cielabA: drift.Value(metrics.cielabA),
          cielabB: drift.Value(metrics.cielabB),
          brokenPercent: drift.Value(metrics.brokenPercent),
          blackPercent: drift.Value(metrics.blackPercent),
          chalkyPercent: drift.Value(metrics.chalkyPercent),
          redPercent: drift.Value(metrics.redPercent),
          yellowPercent: drift.Value(metrics.yellowPercent),
          greenPercent: drift.Value(metrics.greenPercent),
          longPercent: drift.Value(metrics.longPercent),
          mediumPercent: drift.Value(metrics.mediumPercent),
          shortPercent: drift.Value(metrics.shortPercent),
          millingGrade: drift.Value(metrics.millingGrade),
          grainShape: drift.Value(metrics.grainShape),
          grainLength: drift.Value(metrics.grainLength),
          chalkinessStatus: drift.Value(metrics.chalkinessStatus),
          qualityIssues: metrics.qualityIssues != null ? drift.Value(metrics.qualityIssues!) : const drift.Value.absent(),
          modelVersion: drift.Value(RiceQualityModel.modelVersion),
        ),
      );

      // Maintain only last 100 scans
      await _database.deleteOldScans(userId, 100);

      // Get the saved scan
      final scan = await _database.getScanById(scanId);
      
      if (scan == null) {
        throw Exception('Failed to retrieve saved scan');
      }

      if (!mounted) return;

      // Clear the current image
      setState(() {
        _selectedImage = null;
        _validationWarning = null;
        _showGuidance = true;
        _currentPosition = null;
      });

      // Navigate to results
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultsScreen(scan: scan),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error processing image: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Validate image brightness - returns warning message if too dark
  Future<String?> _validateBrightness(File imageFile) async {
    try {
      final Uint8List bytes = await imageFile.readAsBytes();
      final img.Image? image = img.decodeImage(bytes);
      
      if (image == null) return null;

      // Calculate average brightness
      int totalBrightness = 0;
      int pixelCount = 0;

      for (int y = 0; y < image.height; y++) {
        for (int x = 0; x < image.width; x++) {
          final pixel = image.getPixel(x, y);
          // Calculate luminance from RGB
          final r = pixel.r.toInt();
          final g = pixel.g.toInt();
          final b = pixel.b.toInt();
          final brightness = (0.299 * r + 0.587 * g + 0.114 * b).round();
          totalBrightness += brightness;
          pixelCount++;
        }
      }

      final avgBrightness = totalBrightness / pixelCount;

      // If average brightness is below threshold, image is too dark
      if (avgBrightness < 50) {
        return 'Image is too dark. Please ensure good lighting.';
      } else if (avgBrightness < 80) {
        return 'Image brightness is low. Consider better lighting for optimal results.';
      }

      return null;
    } catch (e) {
      return null; // Don't fail validation on errors
    }
  }

  // Validate image sharpness - returns warning message if too blurry
  Future<String?> _validateSharpness(File imageFile) async {
    try {
      final Uint8List bytes = await imageFile.readAsBytes();
      final img.Image? image = img.decodeImage(bytes);
      
      if (image == null) return null;

      // Use Laplacian variance to detect blur
      // Sample center region for performance
      final centerX = image.width ~/ 2;
      final centerY = image.height ~/ 2;
      final sampleSize = 200;

      double variance = 0;
      int count = 0;

      for (int y = centerY - sampleSize; y < centerY + sampleSize && y < image.height - 1; y++) {
        if (y < 1) continue;
        for (int x = centerX - sampleSize; x < centerX + sampleSize && x < image.width - 1; x++) {
          if (x < 1) continue;

          // Simplified Laplacian operator
          final center = image.getPixel(x, y).luminance;
          final left = image.getPixel(x - 1, y).luminance;
          final right = image.getPixel(x + 1, y).luminance;
          final top = image.getPixel(x, y - 1).luminance;
          final bottom = image.getPixel(x, y + 1).luminance;

          final laplacian = (4 * center - left - right - top - bottom).abs();
          variance += laplacian * laplacian;
          count++;
        }
      }

      final avgVariance = count > 0 ? variance / count : 0;

      // If variance is low, image is likely blurry
      if (avgVariance < 100) {
        return 'Image appears blurry. Please ensure the camera is focused and steady.';
      } else if (avgVariance < 200) {
        return 'Image sharpness is low. Try to hold the camera steady.';
      }

      return null;
    } catch (e) {
      return null; // Don't fail validation on errors
    }
  }

  // Validate the captured image
  Future<void> _validateImage(File imageFile) async {
    setState(() {
      _validationWarning = null;
    });

    final brightnessWarning = await _validateBrightness(imageFile);
    final sharpnessWarning = await _validateSharpness(imageFile);

    String? combinedWarning;
    if (brightnessWarning != null && sharpnessWarning != null) {
      combinedWarning = '$brightnessWarning\n$sharpnessWarning';
    } else {
      combinedWarning = brightnessWarning ?? sharpnessWarning;
    }

    if (combinedWarning != null) {
      setState(() {
        _validationWarning = combinedWarning;
      });

      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.orange),
              SizedBox(width: 8),
              Text('Image Quality Warning'),
            ],
          ),
          content: Text(combinedWarning!),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _clearImage();
              },
              child: const Text('Retake'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Continue Anyway'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _pickImageFromGallery() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (image != null) {
        final imageFile = File(image.path);
        setState(() {
          _selectedImage = imageFile;
          _showGuidance = false;
        });
        // Validate the image
        await _validateImage(imageFile);
      }
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image: $error')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _pickImageFromCamera() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );

      if (image != null) {
        final imageFile = File(image.path);
        setState(() {
          _selectedImage = imageFile;
          _showGuidance = false;
        });
        // Validate the image
        await _validateImage(imageFile);
      }
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to capture image: $error')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _clearImage() {
    setState(() {
      _selectedImage = null;
      _validationWarning = null;
      _showGuidance = true;
    });
  }

  Widget _buildGuidanceItem(IconData icon, String title, String description, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Clear Image Button (if image selected)
          if (_selectedImage != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: OutlinedButton.icon(
                  onPressed: _clearImage,
                  icon: const Icon(Icons.clear, size: 18),
                  label: const Text('Clear Image'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                  ),
                ),
              ),
            ),
          
          // Guidance Card - shown when no image is selected
            if (_showGuidance && _selectedImage == null)
              Container(
                margin: const EdgeInsets.all(16.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.lightbulb_outline, color: Colors.blue.shade700),
                        const SizedBox(width: 8),
                        Text(
                          'Capture Guidelines',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildGuidanceItem(
                      Icons.square,
                      'Use a blue background',
                      'Place grains on a solid blue surface for best results',
                      Colors.blue.shade700,
                    ),
                    const SizedBox(height: 8),
                    _buildGuidanceItem(
                      Icons.grid_4x4,
                      'Spread grains in a single layer',
                      'Ensure grains don\'t overlap for accurate analysis',
                      Colors.orange.shade700,
                    ),
                    const SizedBox(height: 8),
                    _buildGuidanceItem(
                      Icons.wb_sunny_outlined,
                      'Use good lighting',
                      'Avoid shadows and ensure even illumination',
                      Colors.amber.shade700,
                    ),
                    const SizedBox(height: 8),
                    _buildGuidanceItem(
                      Icons.camera_outlined,
                      'Keep camera steady',
                      'Hold steady and ensure the image is in focus',
                      Colors.green.shade700,
                    ),
                    const SizedBox(height: 12),
                    const Divider(),
                    const SizedBox(height: 8),
                    // GPS Toggle
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 20, color: Colors.grey.shade700),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Include GPS Location',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ),
                        Switch(
                          value: _enableGPS,
                          onChanged: (value) async {
                            if (value) {
                              await _requestLocationPermission();
                            } else {
                              setState(() {
                                _currentPosition = null;
                              });
                            }
                            setState(() {
                              _enableGPS = value;
                            });
                          },
                        ),
                      ],
                    ),
                    if (_enableGPS && _currentPosition != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 28, top: 4),
                        child: Text(
                          'Location captured: ${_currentPosition!.latitude.toStringAsFixed(6)}, ${_currentPosition!.longitude.toStringAsFixed(6)}',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.green.shade700,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            
            // Validation Warning Banner
            if (_validationWarning != null && _selectedImage != null)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange.shade300),
                ),
                child: Row(
                  children: [
                    Icon(Icons.warning_amber_rounded, color: Colors.orange.shade700),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _validationWarning!,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.orange.shade900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            Expanded(
              child: Center(
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : _selectedImage != null
                        ? Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.file(
                                      _selectedImage!,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      _validationWarning == null 
                                          ? Icons.check_circle 
                                          : Icons.warning_amber_rounded,
                                      color: _validationWarning == null 
                                          ? Colors.green.shade700 
                                          : Colors.orange.shade700,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      _validationWarning == null
                                          ? 'Image captured successfully'
                                          : 'Image captured with warnings',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: _validationWarning == null 
                                            ? Colors.green.shade700 
                                            : Colors.orange.shade700,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.photo_camera_outlined,
                                size: 100,
                                color: Colors.grey.shade400,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Ready to capture',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Follow the guidelines above',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton.icon(
                    onPressed: _isLoading ? null : _pickImageFromCamera,
                    icon: const Icon(Icons.camera_alt),
                    label: const Text(
                      'Take Photo',
                      style: TextStyle(fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: _isLoading ? null : _pickImageFromGallery,
                    icon: const Icon(Icons.photo_library),
                    label: const Text(
                      'Choose from Gallery',
                      style: TextStyle(fontSize: 16),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  if (_selectedImage != null) ...[
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: _isLoading ? null : _processAndSaveImage,
                      icon: _isLoading 
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                            )
                          : const Icon(Icons.analytics),
                      label: Text(
                        _isLoading ? 'Analyzing...' : 'Analyze Rice Quality',
                        style: const TextStyle(fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      );
  }
}
