import 'package:flutter/material.dart';

import '../../domain/entities/entities.dart';
import '../utils/utils.dart';
import '../widgets/widgets.dart';

class DetailCatScreen extends StatelessWidget {
  const DetailCatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Cat cat = ModalRoute.of(context)!.settings.arguments as Cat;
    final size = MediaQuery.of(context).size;
    final scrollCtrl = ScrollController();

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                // Image
                SizedBox(
                  width: double.infinity,
                  height: size.height * 0.5,
                  child: AppUtils().getCatImage(cat.image?.url),
                ),

                // BackButton
                Positioned(
                  top: 8,
                  left: 8,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 60,
                      height: 60,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blueGrey.withOpacity(0.6),
                      ),
                      child: const Icon(Icons.arrow_back_rounded),
                    ),
                  ),
                ),

                // Name
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    width: size.width * 0.75,
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blueGrey.withOpacity(0.6),
                    ),
                    child: Text(
                      cat.name,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // Flag
                FutureBuilder(
                  future: AppUtils().fetchFlag(cat.origin),
                  builder: (context, snapshot) {
                    return Positioned(
                      bottom: 8,
                      right: 8,
                      child: Container(
                        width: 60,
                        height: 40,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blueGrey.withOpacity(0.6),
                        ),
                        child: snapshot.hasData
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  snapshot.data!,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const Center(
                                child: CircularProgressIndicator(),
                              ),
                      ),
                    );
                  },
                ),
              ],
            ),

            //Content
            Expanded(
              child: RawScrollbar(
                controller: scrollCtrl,
                thumbVisibility: true,
                radius: const Radius.circular(20),
                thickness: 4,
                thumbColor: Theme.of(context).colorScheme.primary,
                child: SingleChildScrollView(
                  controller: scrollCtrl,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //origin
                      Text(
                        cat.origin ?? "",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),

                      //Stars widget
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            AtributeWidget(
                              icon: Icons.favorite,
                              label: 'Affection',
                              value: cat.affectionLevel ?? 2,
                            ),
                            AtributeWidget(
                              icon: Icons.flash_on,
                              label: 'Energy',
                              value: cat.energyLevel ?? 2,
                            ),
                            AtributeWidget(
                              icon: Icons.car_crash,
                              label: 'Intelligence',
                              value: cat.intelligence ?? 2,
                            ),
                          ],
                        ),
                      ),

                      //Section largest texts
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _titleDescriptions(context, title: "Temperament"),
                            const SizedBox(height: 10),
                            Text(
                              cat.temperament ?? "",
                              style: const TextStyle(fontSize: 16),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 50),

                            //Description
                            _titleDescriptions(context, title: "Description"),
                            const SizedBox(height: 10),
                            Text(
                              cat.description ?? "",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text _titleDescriptions(BuildContext context, {required String title}) {
    return Text(
      title,
      style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary),
    );
  }
}
