import 'package:flutter/material.dart';
import 'package:social_media_flutter/social_media_flutter.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(
      // <-- wrap your app with a ProviderScope widget
      child: MyApp()));
}

final profileRepositoryProvider = Provider((ref) {
  return ProfileRepository();
});

final profileProvider = Provider((ref) {
  return ref.read(profileRepositoryProvider).getProfile();
});

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'cristikers',
      theme: ThemeData(),
      home: const MyKaardApp(),
    );
  }
}

class MyKaardApp extends ConsumerWidget {
  const MyKaardApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PersonalProfile profileData = ref.read(profileProvider);

    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(),
            child: Stack(children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                                radius: 100,
                                backgroundImage:
                                    NetworkImage(profileData.imgPath)),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              profileData.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.teal,
                                fontSize: 28,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              profileData.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                        .animate()
                        .scaleXY(
                            begin: 0.5,
                            end: 1,
                            duration: 1.seconds,
                            curve: Curves.easeInOut)
                        .fadeIn(duration: 1.seconds, curve: Curves.easeInOut),
                    const SizedBox(
                      height: 5,
                    ),
                    Center(
                        child: Column(
                            children: List.generate(
                                    profileData.socialHandles.length, (index) {
                      var socialHandle = profileData.socialHandles[index];

                      return Container(
                        height: 60,
                        width: 160,
                        margin: const EdgeInsets.only(top: 5),
                        decoration: BoxDecoration(
                          color: socialHandle.bgColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SocialWidget(
                            placeholderText: socialHandle.label,
                            iconData: socialHandle.icon,
                            iconColor: socialHandle.iconColor,
                            iconSize: 24,
                            link: socialHandle.url,
                            placeholderStyle: TextStyle(
                              color: socialHandle.labelColor,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      );
                    })
                                .animate(interval: 100.ms)
                                .slideY(
                                    begin: 1,
                                    end: 0,
                                    duration: 0.25.seconds,
                                    curve: Curves.easeInOut)
                                .fadeIn()))
                  ])
            ])));
  }
}

class SocialHandle {
  final IconData icon;
  final String label;
  final String url;
  final Color iconColor;
  final Color labelColor;
  final Color bgColor;

  SocialHandle(
      {required this.icon,
      required this.label,
      required this.url,
      required this.iconColor,
      required this.labelColor,
      required this.bgColor});
}

class PersonalProfile {
  final String name;
  final String title;
  final List<SocialHandle> socialHandles;
  final String imgPath;

  PersonalProfile(
      {required this.name,
      required this.title,
      required this.imgPath,
      required this.socialHandles});
}

class ProfileRepository {
  PersonalProfile getProfile() {
    var socialHandles = [
      SocialHandle(
          icon: SocialIconsFlutter.instagram,
          label: 'cristikers',
          url: 'https://www.instagram.com/cristikers',
          iconColor: Colors.redAccent,
          labelColor: Colors.black,
          bgColor: Colors.greenAccent),
      SocialHandle(
          icon: SocialIconsFlutter.github,
          label: 'cristicares',
          url: 'https://github.com/cristicares',
          iconColor: Colors.black,
          labelColor: Colors.black,
          bgColor: Colors.greenAccent),
      SocialHandle(
          icon: SocialIconsFlutter.linkedin_box,
          label: 'cristikers',
          url: 'https://www.linkedin.com/in/cristicares/',
          iconColor: Colors.blue,
          labelColor: Colors.black,
          bgColor: Colors.greenAccent),
      SocialHandle(
          icon: SocialIconsFlutter.twitter,
          label: 'cristicares',
          url: 'https://twitter.com/cristicares',
          iconColor: Colors.blue,
          labelColor: Colors.black,
          bgColor: Colors.greenAccent)
    ];

    var personalProfile = PersonalProfile(
        name: 'Cristi Cares',
        title: 'Mobile Developer - Lead Consultant at Thoughtworks',
        imgPath: 'https://avatars.githubusercontent.com/u/4209871?v=4',
        socialHandles: socialHandles);

    return personalProfile;
  }
}
