import 'package:trilhaapp/model/cardDetail.dart';

class CardDetailRepository {
  Future<Carddetail> getCardDetail() async {
    await Future.delayed(const Duration(seconds: 2));
    return Carddetail(
        "São Paulo Futebol Clube",
        "https://pbs.twimg.com/media/FnUFi3yXwAcL-uz.jpg:large",
        "Fundado em 25 de janeiro de 1930 e marcado por histórias de superação, como a refundação do clube em 1935 ou os tempos difíceis da construção do MorumBIS, o Tricolor Mais Querido do planeta é o único clube brasileiro a ter conquistado a América e o Mundo por três vezes. É ainda o único Tricampeão consecutivo do Campeonato Brasileiro e o primeiro a conquistá-lo por seis vezes. Tri-Hexacampeão Brasileiro.",
        1);
  }
}
