import 'dart:ffi';

import 'package:sbterp/data_layer/custsetups/stortype.dart';

class GroubItSubsM {
  String? gitemmain;
  int? gitemid;
  String? gitemsub;
  GroubItSubsM(
      {this.gitemmain,
        this.gitemid,
        this.gitemsub,
      });

  factory GroubItSubsM.formJson(Map<String, dynamic> json) {
    return GroubItSubsM(
      gitemmain: json["gitemmain"] ,
      gitemid: json["gitemid"],
      gitemsub: json["gitemsub"],
    );
  }

  Map toJson() {
    return {
      "gitemmain": gitemmain as String,
      "gitemid": "0",
      "gitemsub": gitemsub as String,
    };
  }
}
