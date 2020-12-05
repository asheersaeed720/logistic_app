import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class PrivacyScreen extends StatelessWidget {
  static const String routeName = '/privacy';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(4),
          child: Html(
            data: """
    <p>Privacyتلتزم شركة هوب إكس بالحفاظ على سریة معلومات المستفید من الخدمات البریدیة وحمایتها من التعدي علیها بأي وسیلة، واتخاذ كافة التدابیر اللازمة لمنع الوصول إلیها أو الاطلاع علیها أو إفشائها أو نشرها أو تعدیلها بما یخالف الأنظمة، كما وتلتزم شركة هوب إكس بعدم الإفصاح عن معلومات المستفیدین ما لم یكن هذا الإفصاح مسموحا به بموجب مسوغ نظامي وفقا للأنظمة المعمول بها في المملكة، أو بناء على موافقة المستفید الصریحة، أو من یمثله رسمیا في ذلك، أو بناء على توجیه من الهیئة، كما وتقید أي اطلاع على معلومات المستفیدین لدیها وتوثق أي دخول على معلوماتهم ،وتحدد وتعرف طلب أغراض جمع وحفظ معلومات المستفیدین، كما وتحافظ على محتوى المواد البریدیة وتحظر على غیر المصرح لهم نظاما بالاطلاع علیها</p>
  """,
            //Optional parameters:
            // padding: EdgeInsets.all(8.0),
            // linkStyle: const TextStyle(
            //   color: Colors.redAccent,
            //   decorationColor: Colors.redAccent,
            //   decoration: TextDecoration.underline,
            // ),
            // onLinkTap: (url) {
            //   print("Opening $url...");
            // },
            // onImageTap: (src) {
            //   print(src);
            // },
            //Must have useRichText set to false for this to work
            // customRender: (node, children) {
            //   if (node is dom.Element) {
            //     switch (node.localName) {
            //       case "custom_tag":
            //         return Column(children: children);
            //     }
            //   }
            //   return null;
            // },
            // customTextAlign: (dom.Node node) {
            //   if (node is dom.Element) {
            //     switch (node.localName) {
            //       case "p":
            //         return TextAlign.justify;
            //     }
            //   }
            //   return null;
            // },
            // customTextStyle: (dom.Node node, TextStyle baseStyle) {
            //   if (node is dom.Element) {
            //     switch (node.localName) {
            //       case "p":
            //         return baseStyle.merge(TextStyle(height: 2, fontSize: 20));
            //     }
            //   }
            //   return baseStyle;
            // },
          ),
        ),
      ),
    );
  }
}
