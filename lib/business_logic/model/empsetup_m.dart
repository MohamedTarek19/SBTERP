

class EmpsetupM {
  String? emp_name;
  int? empcode;
  String? emp_job;

  EmpsetupM(
      {this.emp_name,
        this.emp_job,
        this.empcode
       });
  factory EmpsetupM.formJson(Map<String, dynamic> json) {
    return EmpsetupM(
        emp_name: json["emp_name"] as String,
        emp_job: json["emp_job"] as String,
        empcode: json["empcode"] );
  }

}
