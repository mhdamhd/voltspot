/// This file contains a set of components for displaying different types of failures in a Flutter application.
/// Each failure type has its own corresponding component that handles the visual representation of the failure.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voltspot/core/core_compoent/app_button.dart';
import 'package:voltspot/core/core_compoent/show_toast.dart';
import 'package:voltspot/core/errors/failure.dart';
import 'package:voltspot/core/paths/images_paths.dart';

/// The [FailureComponent] class is a generic component that takes a [Failure] object and dynamically selects the appropriate
/// sub-component based on the runtime type of the failure. It uses a switch statement to determine the failure type and
/// returns the corresponding component for that type.
///

// TODO: customize failure Components view

class FailureComponent extends StatelessWidget {
  const FailureComponent(
      {super.key, required this.failure, this.retry, this.refresh = false});

  final Failure failure;
  final VoidCallback? retry;
  final bool refresh;

  static handleFailure(
      {required BuildContext context, required Failure failure}) {
    showToast(message: failure.message);
  }

  @override
  Widget build(BuildContext context) {
    if (failure is SessionExpiredFailure) {
      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) {
          showToast(message: failure.message);
          //in an app with Auth, we should log out if the session is expired
          // context.read<AppConfigBloc>().add(const LogOutEvent());
          // context.go(LoginRoute.name);
        },
      );
      return const SizedBox();
    }
    if (refresh) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: IconButton(
          icon: Icon(Icons.refresh, size: 40.w, color: Colors.white),
          onPressed: retry,
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(ImagesPaths.failurePng, width: 150.w),
          const SizedBox(height: 20),
          Text(
            failure.message,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 20),
          if (retry != null)
            AppButton(
              onPressed: retry,
              text: "Try Again",
              width: 300.w,
            ),
        ],
      ),
    );


    }
  }


/// The [NoInternetFailureComponent] handles the visual representation of the NoInternetFailure type.
///
class NoInternetFailureComponent extends StatelessWidget {
  const NoInternetFailureComponent({super.key, required this.failure});

  final NoInternetFailure failure;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        failure.message,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}

/// The [ServerFailureComponent] handles the visual representation of the ServerFailure type.
///
class ServerFailureComponent extends StatelessWidget {
  const ServerFailureComponent({super.key, required this.failure});

  final ServerFailure failure;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        failure.toString(),
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}

/// The [UnknownFailureComponent] handles the visual representation of the UnknownFailure type.
///
class UnknownFailureComponent extends StatelessWidget {
  const UnknownFailureComponent({super.key, required this.failure});

  final UnknownFailure failure;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        failure.message,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}

/// The [SessionExpiredFailureComponent] handles the visual representation of the SessionExpiredFailure type.
///
class SessionExpiredFailureComponent extends StatelessWidget {
  const SessionExpiredFailureComponent({super.key, required this.failure});

  final SessionExpiredFailure failure;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        failure.message,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
