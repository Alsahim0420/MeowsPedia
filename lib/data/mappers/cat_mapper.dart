import '../../domain/entities/cat.dart';
import '../models/cat_model.dart';

extension CatModelMapper on CatModel {
  Cat toEntity() {
    return Cat(
      id: id,
      name: name,
      weight: Weight(
        imperial: weight.imperial,
        metric: weight.metric,
      ),
      cfaUrl: cfaUrl,
      vetstreetUrl: vetstreetUrl,
      vcahospitalsUrl: vcahospitalsUrl,
      temperament: temperament,
      origin: origin,
      countryCodes: countryCodes,
      countryCode: countryCode,
      description: description,
      lifeSpan: lifeSpan,
      indoor: indoor,
      lap: lap,
      altNames: altNames,
      adaptability: adaptability,
      affectionLevel: affectionLevel,
      childFriendly: childFriendly,
      dogFriendly: dogFriendly,
      energyLevel: energyLevel,
      grooming: grooming,
      healthIssues: healthIssues,
      intelligence: intelligence,
      sheddingLevel: sheddingLevel,
      socialNeeds: socialNeeds,
      strangerFriendly: strangerFriendly,
      vocalisation: vocalisation,
      experimental: experimental,
      hairless: hairless,
      natural: natural,
      rare: rare,
      rex: rex,
      suppressedTail: suppressedTail,
      shortLegs: shortLegs,
      wikipediaUrl: wikipediaUrl,
      hypoallergenic: hypoallergenic,
      referenceImageId: referenceImageId,
      image: image != null ? CatImage(id: image!.id, url: image!.url) : null,
    );
  }
}
