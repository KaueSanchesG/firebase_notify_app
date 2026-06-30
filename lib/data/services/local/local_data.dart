import 'package:firebase_notify_app/domain/enums/quota_type.dart';
import 'package:firebase_notify_app/domain/models/warning_entity.dart';

class LocalData {
  Future<List<WarningEntity>> getWarnings() async {
    return [
      WarningEntity(
        id: 1,
        message:
            "Enchente detectada no bairro Rio de Janeiro, próximo à rua das Laranjeiras.",
        quota: QuotaType.moderate,
        timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
      ),
      WarningEntity(
        id: 2,
        message:
            "Alerta emitido no bairro Centro, próximo à academia Fit. Possível manifestação no local.",
        quota: QuotaType.minor,
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      WarningEntity(
        id: 3,
        message:
            "Deslizamento de terra bloqueando parcialmente a rodovia no km 35. Trânsito operando em meia pista.",
        quota: QuotaType.major,
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
      WarningEntity(
        id: 4,
        message:
            "Forte chuva de granizo prevista para a região sul da cidade. Proteja seus veículos e evite áreas abertas.",
        quota: QuotaType.moderate,
        timestamp: DateTime.now().subtract(
          const Duration(hours: 1, minutes: 30),
        ),
      ),
      WarningEntity(
        id: 5,
        message:
            "Queda de árvore rompendo cabos de energia na Avenida das Torres. Equipes já acionadas.",
        quota: QuotaType.major,
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
      ),
      WarningEntity(
        id: 6,
        message:
            "Semáforo inoperante no cruzamento principal do bairro Batel. Reduza a velocidade ao se aproximar.",
        quota: QuotaType.minor,
        timestamp: DateTime.now().subtract(const Duration(hours: 5)),
      ),
      WarningEntity(
        id: 7,
        message:
            "Risco de transbordamento de rio devido às chuvas contínuas. Moradores ribeirinhos devem ficar em alerta.",
        quota: QuotaType.moderate,
        timestamp: DateTime.now().subtract(const Duration(minutes: 45)),
      ),
    ];
  }
}
