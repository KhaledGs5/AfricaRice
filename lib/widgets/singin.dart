import 'package:africa_rice/data/database/app_database.dart';
import 'package:africa_rice/widgets/signup.dart';
import 'package:africa_rice/widgets/capture.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
	const SignIn({super.key});

	@override
	State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
	final _formKey = GlobalKey<FormState>();
	final _usernameController = TextEditingController();
	final _roleController = TextEditingController();
	late final AppDatabase _database;
	bool _isLoading = false;

	@override
	void initState() {
		super.initState();
		_database = AppDatabase();
	}

	@override
	void dispose() {
		_usernameController.dispose();
		_roleController.dispose();
		_database.close();
		super.dispose();
	}

	Future<void> _handleSignIn() async {
		if (!_formKey.currentState!.validate()) {
			return;
		}

		setState(() {
			_isLoading = true;
		});

		final username = _usernameController.text.trim();
		final role = _roleController.text.trim();

		try {
			final query = _database.select(_database.users)
				..where((tbl) => tbl.username.equals(username))
				..where((tbl) => tbl.role.equals(role));

			final user = await query.getSingleOrNull();

			if (!mounted) return;

			if (user == null) {
				ScaffoldMessenger.of(context).showSnackBar(
					const SnackBar(content: Text('No matching user found.')),
				);
			} else {
				Navigator.of(context).pushReplacement(
					MaterialPageRoute(
						builder: (_) => const Capture(),
					),
				);
			}
		} catch (error) {
			if (!mounted) return;
			ScaffoldMessenger.of(context).showSnackBar(
				SnackBar(content: Text('Unable to sign in: $error')),
			);
		} finally {
			if (mounted) {
				setState(() {
					_isLoading = false;
				});
			}
		}
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Text('Sign In'),
				centerTitle: true,
			),
			body: SafeArea(
				child: SingleChildScrollView(
					padding: const EdgeInsets.all(24),
					child: Form(
						key: _formKey,
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.stretch,
							children: [
								const SizedBox(height: 40),
								const Text(
									'Welcome Back',
									style: TextStyle(
										fontSize: 32,
										fontWeight: FontWeight.bold,
									),
									textAlign: TextAlign.center,
								),
								const SizedBox(height: 8),
								const Text(
									'Use the details you registered with to continue.',
									style: TextStyle(fontSize: 16, color: Colors.grey),
									textAlign: TextAlign.center,
								),
								const SizedBox(height: 48),
								TextFormField(
									controller: _usernameController,
									decoration: InputDecoration(
										labelText: 'Username',
										hintText: 'Enter your username',
										prefixIcon: const Icon(Icons.person_outline),
										border: OutlineInputBorder(
											borderRadius: BorderRadius.circular(12),
										),
									),
									validator: (value) {
										if (value == null || value.trim().isEmpty) {
											return 'Username is required';
										}
										return null;
									},
								),
								const SizedBox(height: 20),
								TextFormField(
									controller: _roleController,
									decoration: InputDecoration(
										labelText: 'Role',
										hintText: 'Enter your role',
										prefixIcon: const Icon(Icons.work_outline),
										border: OutlineInputBorder(
											borderRadius: BorderRadius.circular(12),
										),
									),
									validator: (value) {
										if (value == null || value.trim().isEmpty) {
											return 'Role is required';
										}
										return null;
									},
								),
								const SizedBox(height: 40),
								ElevatedButton(
									onPressed: _isLoading ? null : _handleSignIn,
									style: ElevatedButton.styleFrom(
										padding: const EdgeInsets.symmetric(vertical: 16),
										shape: RoundedRectangleBorder(
											borderRadius: BorderRadius.circular(12),
										),
									),
									child: _isLoading
											? const SizedBox(
													height: 20,
													width: 20,
													child: CircularProgressIndicator(strokeWidth: 2),
												)
											: const Text(
													'Sign In',
													style: TextStyle(fontSize: 18),
												),
								),
								const SizedBox(height: 16),
								TextButton(
									onPressed: () {
										Navigator.of(context).pushReplacement(
											MaterialPageRoute(
												builder: (_) => const SignUp(),
											),
										);
									},
									child: const Text('Need an account? Sign Up'),
								),
							],
						),
					),
				),
			),
		);
	}
}
