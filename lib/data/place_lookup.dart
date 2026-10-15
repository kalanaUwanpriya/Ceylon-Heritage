import 'package:flutter/material.dart';

import '../data/abhayagiriya_places.dart';
import '../data/dambulla_places.dart';
import '../data/gadaladeniya_places.dart';
import '../data/ibbankatuwa_places.dart';
import '../data/jetavanaramaya_places.dart';
import '../data/lankathilaka_places.dart';
import '../data/place_information_data.dart';
import '../data/ruwanwelisaya_places.dart';
import '../data/sigiriya_places.dart';
import '../data/sri_maha_bodhi_places.dart';
import '../data/thuparamaya_places.dart';
import '../destinations/abhayagiriya_detail_page.dart';
import '../destinations/dambulla_detail_page.dart';
import '../destinations/gadaladeniya_detail_page.dart';
import '../destinations/ibbankatuwa_detail_page.dart';
import '../destinations/jetavanaramaya_detail_page.dart';
import '../destinations/lankathilaka_detail_page.dart';
import '../destinations/ruwanwelisaya_detail_page.dart';
import '../destinations/sigiriya_detail_page.dart';
import '../destinations/sri_maha_bodhi_detail_page.dart';
import '../destinations/thuparamaya_detail_page.dart';

class PlaceDetails {
  final String id;
  final String name;
  final String destinationName;
  final String location;
  final String description;
  final String image;
  final Widget Function(BuildContext)? pageBuilder;

  const PlaceDetails({
    required this.id,
    required this.name,
    required this.destinationName,
    required this.location,
    required this.description,
    required this.image,
    this.pageBuilder,
  });
}

class PlaceLookup {
  static String normalizeId(String input) {
    return input
        .toLowerCase()
        .trim()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
        .replaceAll(RegExp(r'^_+|_+$'), '');
  }

  static PlaceDetails lookup(String rawIdOrName) {
    final norm = normalizeId(rawIdOrName);

    // Guard: service IDs should never be treated as historical destinations
    if (norm.startsWith('service_')) {
      return PlaceDetails(
        id: norm,
        name: rawIdOrName,
        destinationName: 'Service',
        location: 'Sri Lanka',
        description: 'Service in Sri Lanka.',
        image: 'assets/images/sigiriya_rock_fortress.jpg',
      );
    }

    // 1. Sigiriya
    if (norm.contains('sigiriya')) {
      return PlaceDetails(
        id: 'sigiriya_rock_fortress',
        name: SigiriyaData.placeName,
        destinationName: SigiriyaData.destinationName,
        location: SigiriyaData.location,
        description: SigiriyaData.aboutDescription,
        image: SigiriyaData.heroImages.isNotEmpty
            ? SigiriyaData.heroImages.first
            : 'assets/images/sigiriya_rock_fortress.jpg',
        pageBuilder: (context) => const SigiriyaDetailPage(),
      );
    }

    // 2. Dambulla Cave Temple
    if (norm.contains('dambulla')) {
      return PlaceDetails(
        id: 'dambulla_cave_temple',
        name: DambullaData.placeName,
        destinationName: DambullaData.destinationName,
        location: DambullaData.location,
        description: DambullaData.aboutDescription,
        image: DambullaData.heroImages.isNotEmpty
            ? DambullaData.heroImages.first
            : 'assets/images/dambulla_cave_temple.jpg',
        pageBuilder: (context) => const DambullaDetailPage(),
      );
    }

    // 3. Ibbankatuwa
    if (norm.contains('ibbankatuwa')) {
      return PlaceDetails(
        id: 'ibbankatuwa_megalithic_tombs',
        name: IbbankatuwaData.placeName,
        destinationName: IbbankatuwaData.destinationName,
        location: IbbankatuwaData.location,
        description: IbbankatuwaData.aboutDescription,
        image: IbbankatuwaData.heroImages.isNotEmpty
            ? IbbankatuwaData.heroImages.first
            : 'assets/images/ibbankatuwa_megalithic_tombs.jpg',
        pageBuilder: (context) => const IbbankatuwaDetailPage(),
      );
    }

    // 4. Ruwanwelisaya
    if (norm.contains('ruwanweli')) {
      return PlaceDetails(
        id: 'ruwanwelisaya',
        name: RuwanwelisayaData.placeName,
        destinationName: RuwanwelisayaData.destinationName,
        location: RuwanwelisayaData.location,
        description: RuwanwelisayaData.aboutDescription,
        image: RuwanwelisayaData.heroImages.isNotEmpty
            ? RuwanwelisayaData.heroImages.first
            : 'assets/images/anurapura 3.png',
        pageBuilder: (context) => const RuwanwelisayaDetailPage(),
      );
    }

    // 5. Sri Maha Bodhi
    if (norm.contains('bodhi') || norm.contains('bodhiya')) {
      return PlaceDetails(
        id: 'sri_maha_bodhi',
        name: SriMahaBodhiData.placeName,
        destinationName: SriMahaBodhiData.destinationName,
        location: SriMahaBodhiData.location,
        description: SriMahaBodhiData.aboutDescription,
        image: SriMahaBodhiData.heroImages.isNotEmpty
            ? SriMahaBodhiData.heroImages.first
            : 'assets/images/anurapura 4.png',
        pageBuilder: (context) => const SriMahaBodhiDetailPage(),
      );
    }

    // 6. Thuparamaya
    if (norm.contains('thuparamaya')) {
      return PlaceDetails(
        id: 'thuparamaya',
        name: ThuparamayaData.placeName,
        destinationName: ThuparamayaData.destinationName,
        location: ThuparamayaData.location,
        description: ThuparamayaData.aboutDescription,
        image: ThuparamayaData.heroImages.isNotEmpty
            ? ThuparamayaData.heroImages.first
            : 'assets/images/anurapura 6.png',
        pageBuilder: (context) => const ThuparamayaDetailPage(),
      );
    }

    // 7. Abhayagiriya
    if (norm.contains('abhayagiri')) {
      return PlaceDetails(
        id: 'abhayagiriya',
        name: AbhayagiriyaData.placeName,
        destinationName: AbhayagiriyaData.destinationName,
        location: AbhayagiriyaData.location,
        description: AbhayagiriyaData.aboutDescription,
        image: AbhayagiriyaData.heroImages.isNotEmpty
            ? AbhayagiriyaData.heroImages.first
            : 'assets/images/anurapura 5.png',
        pageBuilder: (context) => const AbhayagiriyaDetailPage(),
      );
    }

    // 8. Jetavanaramaya
    if (norm.contains('jetavana')) {
      return PlaceDetails(
        id: 'jetavanaramaya',
        name: JetavanaramayaData.placeName,
        destinationName: JetavanaramayaData.destinationName,
        location: JetavanaramayaData.location,
        description: JetavanaramayaData.aboutDescription,
        image: JetavanaramayaData.heroImages.isNotEmpty
            ? JetavanaramayaData.heroImages.first
            : 'assets/images/anurapura 2.png',
        pageBuilder: (context) => const JetavanaramayaDetailPage(),
      );
    }

    // 9. Gadaladeniya
    if (norm.contains('gadaladeniya')) {
      return PlaceDetails(
        id: 'gadaladeniya_vihara',
        name: GadaladeniyaData.placeName,
        destinationName: 'Kandy',
        location: GadaladeniyaData.location,
        description: GadaladeniyaData.aboutDescription,
        image: GadaladeniyaData.heroImages.isNotEmpty
            ? GadaladeniyaData.heroImages.first
            : 'assets/images/gadaladeniya_vihara.jpg',
        pageBuilder: (context) => const GadaladeniyaDetailPage(),
      );
    }

    // 10. Lankathilaka
    if (norm.contains('lankathilaka')) {
      return PlaceDetails(
        id: 'lankathilaka_vihara',
        name: LankathilakaData.placeName,
        destinationName: 'Kandy',
        location: LankathilakaData.location,
        description: LankathilakaData.aboutDescription,
        image: LankathilakaData.heroImages.isNotEmpty
            ? LankathilakaData.heroImages.first
            : 'assets/images/lankathilaka_vihara.jpg',
        pageBuilder: (context) => const LankathilakaDetailPage(),
      );
    }

    // Polonnaruwa Attractions
    if (norm.contains('gal_viharaya')) {
      return PlaceDetails(
        id: 'gal_viharaya',
        name: 'Gal Viharaya',
        destinationName: 'Polonnaruwa',
        location: 'Polonnaruwa, Sri Lanka',
        description: galViharayaInformation.description,
        image: 'assets/images/gal_viharaya.png',
        pageBuilder: (context) => galViharayaInformation,
      );
    }
    if (norm.contains('royal_palace')) {
      return PlaceDetails(
        id: 'royal_palace',
        name: 'Royal Palace',
        destinationName: 'Polonnaruwa',
        location: 'Polonnaruwa, Sri Lanka',
        description: royalPalaceInformation.description,
        image: 'assets/images/royal_palace.png',
        pageBuilder: (context) => royalPalaceInformation,
      );
    }
    if (norm.contains('rankoth_vehera')) {
      return PlaceDetails(
        id: 'rankoth_vehera',
        name: 'Rankoth Vehera',
        destinationName: 'Polonnaruwa',
        location: 'Polonnaruwa, Sri Lanka',
        description: rankothVeheraInformation.description,
        image: 'assets/images/rankoth_vehera.png',
        pageBuilder: (context) => rankothVeheraInformation,
      );
    }
    if (norm.contains('parakrama_samudraya')) {
      return PlaceDetails(
        id: 'parakrama_samudraya',
        name: 'Parakrama Samudraya',
        destinationName: 'Polonnaruwa',
        location: 'Polonnaruwa, Sri Lanka',
        description: parakramaSamudrayaInformation.description,
        image: 'assets/images/parakrama_samudraya.png',
        pageBuilder: (context) => parakramaSamudrayaInformation,
      );
    }

    // Jaffna Attractions
    if (norm.contains('nallur')) {
      return PlaceDetails(
        id: 'nallur_kandaswamy_kovil',
        name: 'Nallur Kandaswamy Kovil',
        destinationName: 'Jaffna',
        location: 'Nallur, Jaffna, Sri Lanka',
        description: nallurKandaswamyInformation.description,
        image: 'assets/images/nallur_kandaswamy.png',
        pageBuilder: (context) => nallurKandaswamyInformation,
      );
    }
    if (norm.contains('jaffna_fort')) {
      return PlaceDetails(
        id: 'jaffna_fort',
        name: 'Jaffna Fort',
        destinationName: 'Jaffna',
        location: 'Jaffna, Sri Lanka',
        description: jaffnaFortInformation.description,
        image: 'assets/images/jaffna_fort.png',
        pageBuilder: (context) => jaffnaFortInformation,
      );
    }
    if (norm.contains('jaffna_library') || norm.contains('public_library')) {
      return PlaceDetails(
        id: 'jaffna_public_library',
        name: 'Jaffna Public Library',
        destinationName: 'Jaffna',
        location: 'Jaffna, Sri Lanka',
        description: jaffnaLibraryInformation.description,
        image: 'assets/images/jaffna_library.png',
        pageBuilder: (context) => jaffnaLibraryInformation,
      );
    }
    if (norm.contains('nagadeepa') || norm.contains('casuarina')) {
      return PlaceDetails(
        id: 'nagadeepa_purana_viharaya',
        name: 'Nagadeepa Purana Viharaya',
        destinationName: 'Jaffna',
        location: 'Nainativu Island, Jaffna, Northern Province',
        description: nagadeepaInformation.description,
        image: 'assets/images/nagadeepa.jpeg',
        pageBuilder: (context) => nagadeepaInformation,
      );
    }
    if (norm.contains('delft')) {
      return PlaceDetails(
        id: 'delft_island',
        name: 'Delft Island',
        destinationName: 'Jaffna',
        location: 'Delft Island, Jaffna, Sri Lanka',
        description: delftIslandInformation.description,
        image: 'assets/images/delft_island.png',
        pageBuilder: (context) => delftIslandInformation,
      );
    }

    // Down South Attractions
    if (norm.contains('galle_fort')) {
      return PlaceDetails(
        id: 'galle_fort',
        name: 'Galle Fort',
        destinationName: 'Down South',
        location: 'Galle, Southern Province',
        description: galleFortInformation.description,
        image: 'assets/images/galle_fort.png',
        pageBuilder: (context) => galleFortInformation,
      );
    }
    if (norm.contains('mulgirigala')) {
      return PlaceDetails(
        id: 'mulgirigala_raja_maha_vihara',
        name: 'Mulgirigala Raja Maha Vihara',
        destinationName: 'Down South',
        location: 'Mulgirigala, Southern Province',
        description: mulgirigalaInformation.description,
        image: 'assets/images/mulgirigala.png',
        pageBuilder: (context) => mulgirigalaInformation,
      );
    }
    if (norm.contains('kushta')) {
      return PlaceDetails(
        id: 'kushtarajagala',
        name: 'Kushtarajagala',
        destinationName: 'Down South',
        location: 'Weligama, Southern Province',
        description: kushtaRajaGalaInformation.description,
        image: 'assets/images/kushtarajagala.png',
        pageBuilder: (context) => kushtaRajaGalaInformation,
      );
    }
    if (norm.contains('star_fort')) {
      return PlaceDetails(
        id: 'star_fort',
        name: 'Star Fort',
        destinationName: 'Down South',
        location: 'Matara, Southern Province',
        description: starFortInformation.description,
        image: 'assets/images/star_fort.png',
        pageBuilder: (context) => starFortInformation,
      );
    }
    if (norm.contains('ariyapala') || norm.contains('mask')) {
      return PlaceDetails(
        id: 'ariyapala_masks_museum',
        name: 'Ariyapala Masks Museum',
        destinationName: 'Down South',
        location: 'Ambalangoda, Southern Province',
        description: ariyapalaMasksInformation.description,
        image: 'assets/images/ariyapala_masks.png',
        pageBuilder: (context) => ariyapalaMasksInformation,
      );
    }

    // Kandy Attractions
    if (norm.contains('dalada') || norm.contains('tooth')) {
      return PlaceDetails(
        id: 'sri_dalada_maligawa',
        name: 'Sri Dalada Maligawa',
        destinationName: 'Kandy',
        location: 'Kandy, Central Province',
        description: sriDaladaMaligawaInformation.description,
        image: 'assets/images/sri_dalada_maligawa.png',
        pageBuilder: (context) => sriDaladaMaligawaInformation,
      );
    }
    if (norm.contains('bahirawakanda')) {
      return PlaceDetails(
        id: 'bahirawakanda_buddha_statue',
        name: 'Bahirawakanda Buddha Statue',
        destinationName: 'Kandy',
        location: 'Kandy, Central Province',
        description: bahirawakandaBuddhaInformation.description,
        image: 'assets/images/bahirawakanda.png',
        pageBuilder: (context) => bahirawakandaBuddhaInformation,
      );
    }
    if (norm.contains('ahalepola') || norm.contains('ehalepola')) {
      return PlaceDetails(
        id: 'ehalepola_wax_museum',
        name: 'Ehalepola Wax Museum',
        destinationName: 'Kandy',
        location: 'Kandy, Central Province',
        description: ahalepolaWalawwaInformation.description,
        image: 'assets/images/ahalepola_walawwa.png',
        pageBuilder: (context) => ahalepolaWalawwaInformation,
      );
    }

    // Generic fallback
    return PlaceDetails(
      id: norm.isEmpty ? 'place' : norm,
      name: rawIdOrName,
      destinationName: 'Sri Lanka',
      location: 'Sri Lanka',
      description: 'Historical attraction in Sri Lanka.',
      image: 'assets/images/sigiriya_rock_fortress.jpg',
    );
  }
}
