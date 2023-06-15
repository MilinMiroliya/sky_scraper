import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sky_scraper/provider/weather_provider.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

TextEditingController searchController = TextEditingController();

class _WeatherPageState extends State<WeatherPage> {
  @override
  Widget build(BuildContext context) {
    Provider.of<WeatherProvider>(context).getWeatherData();
    return Consumer<WeatherProvider>(
      builder: (context, provider, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: (!provider.isLoading || provider.forecastList.isEmpty)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (provider.isSearch)
                        ? Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 20, right: 20),
                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: TextField(
                                  controller: searchController,
                                  onSubmitted: (val) {
                                    provider.changeLocation(val);
                                  },
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Search Your Location..",
                                  ),
                                ),
                              )
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(CupertinoIcons.bars),
                              ),
                              Text(
                                provider.city,
                                style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: const Color(0xff2f2f85),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  provider.toSearch();
                                },
                                icon: const Icon(CupertinoIcons.add),
                              ),
                            ],
                          ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/cloudy.png",
                          width: 200,
                          height: 200,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Mostly Sunny",
                                style: GoogleFonts.openSans(
                                  fontSize: 26,
                                  color: const Color(0xff8a8ab3),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                // "32°",
                                "${provider.forecastList.first.code}°",
                                style: GoogleFonts.openSans(
                                  color: const Color(0xff2f2f85),
                                  fontSize: 66,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Mostly Sunny",
                                style: GoogleFonts.openSans(
                                  fontSize: 16,
                                  color: const Color(0xff8a8ab3),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                // "32°",
                                "${provider.forecastList.first.code}°",
                                style: GoogleFonts.openSans(
                                  color: const Color(0xff2f2f85),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      height: 320,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(0xff2f2f85),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              "Today",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: provider.forecastList
                                    .map(
                                      (e) => Container(
                                        margin: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white.withOpacity(0.3),
                                        ),
                                        height: 120,
                                        width: 80,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Column(
                                            children: [
                                              Text(
                                                "${e.day}",
                                                style: GoogleFonts.openSans(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "${e.code}°",
                                                style: GoogleFonts.openSans(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Image.asset(
                                                width: 40,
                                                height: 40,
                                                "assets/images/1.png",
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
