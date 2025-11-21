import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ub_t/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:ub_t/core/common/cubits/app_user/app_user_state.dart';

import 'package:ub_t/core/common/widgets/loader.dart';
import 'package:ub_t/core/theme/app_pallete.dart';
import 'package:ub_t/core/utils/show_snackbar.dart';
import 'package:ub_t/features/courses/presentation/bloc/course_bloc.dart';
import 'package:ub_t/features/courses/presentation/bloc/course_event.dart';
import 'package:ub_t/features/courses/presentation/bloc/course_state.dart';

class CourseSelectionPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const CourseSelectionPage(),
      );

  const CourseSelectionPage({super.key});

  @override
  State<CourseSelectionPage> createState() => _CourseSelectionPageState();
}

class _CourseSelectionPageState extends State<CourseSelectionPage> {
  bool _showCarryOvers = false;

  @override
  void initState() {
    super.initState();
    _loadCourses();
  }

  void _loadCourses() {
    final userState = context.read<AppUserCubit>().state;
    if (userState is AppUserLoggedIn) {
      context.read<CourseBloc>().add(
            LoadAvailableCourses(
              department: userState.user.department,
              level: userState.user.level,
              includeCarryOvers: _showCarryOvers,
            ),
          );
    }
  }

  void _registerCourses() {
    final userState = context.read<AppUserCubit>().state;
    if (userState is AppUserLoggedIn) {
      context.read<CourseBloc>().add(
            RegisterSelectedCourses(userState.user.id),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Your Courses'),
        automaticallyImplyLeading: false,
      ),
      body: BlocConsumer<CourseBloc, CourseState>(
        listener: (context, state) {
          if (state is CourseFailure) {
            showErrorSnackBar(context, state.message);
          } else if (state is CourseRegistrationSuccess) {
            showSuccessSnackBar(context, 'Courses registered successfully!');
            Navigator.of(context).pushReplacementNamed('/home');
          }
        },
        builder: (context, state) {
          if (state is CourseLoading) {
            return const Loader();
          }

          if (state is CoursesLoaded) {
            return Column(
              children: [
                if (state.clashes.isNotEmpty)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    color: AppPallete.warningColor.withOpacity(0.1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.warning, color: AppPallete.warningColor),
                            SizedBox(width: 8),
                            Text(
                              'Course Clashes Detected',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppPallete.warningColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ...state.clashes.map((clash) => Text(
                              '• $clash',
                              style: const TextStyle(fontSize: 12),
                            )),
                      ],
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${state.selectedCourses.length} courses selected',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            _showCarryOvers = !_showCarryOvers;
                          });
                          _loadCourses();
                        },
                        icon: Icon(
                          _showCarryOvers
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        label: Text(
                          _showCarryOvers
                              ? 'Hide Carry-overs'
                              : 'Show Carry-overs',
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: state.courses.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.school_outlined,
                                size: 64,
                                color: Colors.grey,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No courses available',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Please contact your administrator',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: state.courses.length,
                          itemBuilder: (context, index) {
                            final course = state.courses[index];
                            final isSelected = state.selectedCourses.any(
                              (c) => c.courseCode == course.courseCode,
                            );

                            return Card(
                              margin: const EdgeInsets.only(bottom: 12),
                              child: CheckboxListTile(
                                value: isSelected,
                                onChanged: (value) {
                                  context.read<CourseBloc>().add(
                                        ToggleCourseSelection(course.courseCode),
                                      );
                                },
                                title: Text(
                                  '${course.courseCode} - ${course.courseName}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 4),
                                    Text('${course.day} • ${_formatTime(course.startTime)} - ${_formatTime(course.endTime)}'),
                                    Text('Venue: ${course.venueName}'),
                                    if (course.lecturerName != null)
                                      Text('Lecturer: ${course.lecturerName}'),
                                    if (course.level != context.read<AppUserCubit>().state.asLoggedIn?.user.level)
                                      Container(
                                        margin: const EdgeInsets.only(top: 4),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppPallete.warningColor.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          'Level ${course.level} (Carry-over)',
                                          style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                activeColor: AppPallete.primarySkyBlue,
                              ),
                            );
                          },
                        ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: state.selectedCourses.isEmpty
                            ? null
                            : _registerCourses,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppPallete.primarySkyBlue,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: Colors.grey,
                        ),
                        child: const Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          return const Center(
            child: Text('Something went wrong'),
          );
        },
      ),
    );
  }

  String _formatTime(DateTime time) {
    final hour = time.hour;
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}

extension on Color {
  Color withOpacity(double d) => throw UnimplementedError();
}

extension on AppUserState {
  AppUserLoggedIn? get asLoggedIn {
    if (this is AppUserLoggedIn) {
      return this as AppUserLoggedIn;
    }
    return null;
  }
}
