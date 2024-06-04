import 'package:flutter/material.dart';

class PoliticaPrivacidadeView extends StatefulWidget {
  const PoliticaPrivacidadeView({super.key});
    static const routeName = 'politicas';


  @override
  State<PoliticaPrivacidadeView> createState() => _PoliticaPrivacidadeView();
}

class _PoliticaPrivacidadeView extends State<PoliticaPrivacidadeView> {
  var title1 = 'Presence';
  var title2 = 'Jor';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        backgroundColor: Color.fromARGB(255, 26, 33, 225),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Política de Privacidade',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        // Espaçamento com o mesmo valor nas 4 extremidades
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      title1,
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 17, 17, 17),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      title2,
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              const Text(
                "PrecenJor é um aplicativo para a confirmação de presença em eventos, sejam eles apresentações, shows, entre outros que envolvam confirmar a presença de uma pessoa.\n\nTem como um dos focos ser intuitivo e simples.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 30),
              const Text(
                "By PresenceJor",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 50),
              const Text(
                'Política de Privacidade\n\n'
                'A sua privacidade é importante para nós. É política do PrecenJor respeitar a sua privacidade em relação a qualquer informação sua que possamos coletar no aplicativo PrecenJor.\n\n'
                'Informações que Coletamos\n'
                'Coletamos informações que você nos fornece diretamente, como nome, e-mail e informações de contato, quando você se inscreve no aplicativo e confirma sua presença em eventos. Também podemos coletar informações sobre a sua localização para proporcionar serviços mais precisos, como a exibição de eventos próximos a você.\n\n'
                'Uso das Informações\n'
                'As informações coletadas são utilizadas para:\n'
                '- Confirmar sua presença em eventos.\n'
                '- Personalizar sua experiência no aplicativo.\n'
                '- Melhorar nossos serviços e funcionalidades.\n'
                '- Enviar notificações sobre eventos e atualizações relevantes.\n\n'
                'Compartilhamento das Informações\n'
                'Nós não compartilhamos suas informações pessoais com terceiros, exceto nos casos necessários para:\n'
                '- Cumprir com a lei ou processos legais.\n'
                '- Proteger nossos direitos e propriedades.\n'
                '- Facilitar eventos em parceria com organizadores que necessitam de confirmação de presença.\n\n'
                'Segurança das Informações\n'
                'Nos comprometemos a proteger suas informações pessoais. Utilizamos medidas de segurança apropriadas para proteger contra acesso, alteração, divulgação ou destruição não autorizada de suas informações pessoais.\n\n'
                'Retenção das Informações\n'
                'Reteremos suas informações pessoais apenas pelo tempo necessário para fornecer nossos serviços ou conforme necessário para cumprir com nossas obrigações legais.\n\n'
                'Seus Direitos\n'
                'Você tem o direito de acessar, corrigir, atualizar ou solicitar a exclusão de suas informações pessoais a qualquer momento. Para isso, entre em contato conosco através das informações fornecidas no aplicativo.\n\n'
                'Alterações a esta Política de Privacidade\n'
                'Podemos atualizar nossa política de privacidade de tempos em tempos. Notificaremos você sobre quaisquer alterações publicando a nova política de privacidade no aplicativo. Recomendamos que você revise esta política periodicamente para se manter informado sobre como protegemos suas informações.\n\n'
                'Contato\n'
                'Se você tiver qualquer dúvida sobre esta Política de Privacidade, entre em contato conosco através do e-mail: [janio.santos@unaerp.edu.br].\n\n'
                'Data Efetiva\n'
                'Esta Política de Privacidade é efetiva a partir de [02/05/2024].',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 50),
              ClipOval(
                child: Material(
                  color: Colors.blue, // Button color
                  child: InkWell(
                    splashColor: Color.fromARGB(255, 132, 174, 237), // Splash color
                    onTap: () {
                      Navigator.popAndPushNamed(context, 'Home');
                    },
                    child: SizedBox(
                      width: 56,
                      height: 56,
                      child: Icon(Icons.reply),
                    ),
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
