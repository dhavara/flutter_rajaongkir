part of 'pages.dart';

class Ongkirpage extends StatefulWidget {
  const Ongkirpage({Key? key}) : super(key: key);

  @override
  _OngkirpageState createState() => _OngkirpageState();
}

class _OngkirpageState extends State<Ongkirpage> {
  bool isLoading = false;
  String dropdownvalue = 'JNE';
  var kurir = ['JNE', 'POS', 'TIKI'];

  final ctrlBerat = TextEditingController();

  dynamic provId;
  dynamic provinceData;
  dynamic selectedProv;
  dynamic provId2;
  dynamic provinceData2;
  dynamic selectedProv2;
  Future<List<Province>> getProvinces() async {
    dynamic listProvince;
    await MasterDataService.getProvince().then((value) {
      setState(() {
        listProvince = value;
      });
    });
    return listProvince;
  }

  dynamic cityId;
  dynamic cityData;
  dynamic selectedCity;
  dynamic cityId2;
  dynamic cityData2;
  dynamic selectedCity2;
  Future<List<City>> getCities(dynamic provId) async {
    dynamic listCity;
    await MasterDataService.getCity(provId).then((value) {
      setState(() {
        listCity = value;
      });
    });
    return listCity;
  }

  @override
  void initState() {
    super.initState();
    provinceData = getProvinces();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hitung Ongkir"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  //Flexible untuk form
                  Flexible(
                    flex: 2,
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DropdownButton(
                                value: dropdownvalue,
                                icon: const Icon(Icons.arrow_drop_down),
                                items: kurir.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownvalue = newValue!;
                                  });
                                }),
                            SizedBox(
                                width: 200,
                                child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: ctrlBerat,
                                    decoration: const InputDecoration(
                                        labelText: 'Berat (gr)'),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      // ignore: unrelated_type_equality_checks
                                      return value == null || value == 0
                                          ? 'Berat harus diisi atau tidak boleh 0'
                                          : null;
                                    }))
                          ],
                        ),
                      ),

                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Origin",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            )),
                      ),

                      //Provinsi Origin
                      Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 150,
                                    child: FutureBuilder<List<Province>>(
                                        future: provinceData,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return DropdownButton(
                                                isExpanded: true,
                                                value: selectedProv,
                                                icon: const Icon(
                                                    Icons.arrow_drop_down),
                                                iconSize: 30,
                                                elevation: 16,
                                                style: const TextStyle(
                                                    color: Colors.black),
                                                hint: selectedProv == null
                                                    ? const Text('Pilih Provinsi')
                                                    : Text(selectedProv.province),
                                                items: snapshot.data!.map<
                                                        DropdownMenuItem<Province>>(
                                                    (Province value) {
                                                  return DropdownMenuItem(
                                                      value: value,
                                                      child: Text(value.province
                                                          .toString()));
                                                }).toList(),
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    selectedProv = newValue;
                                                    provId = selectedProv.provinceId;
                                                  });
                                                  selectedCity = null;
                                                  cityData = getCities(provId);
                                                });
                                          } else if (snapshot.hasError) {
                                            return const Text("Tidak ada Data");
                                          }
                                          return UiLoading.loadingDD();
                                        }),
                                  )
                                ],
                              )),

                              //City Origin
                              Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: selectedProv == null ? 
                                const Text("Pilih Provinsi Dulu!") : 
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 150,
                                    child: FutureBuilder<List<City>>(
                                        future: cityData,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return DropdownButton(
                                                isExpanded: true,
                                                value: selectedCity,
                                                icon: const Icon(
                                                    Icons.arrow_drop_down),
                                                iconSize: 30,
                                                elevation: 16,
                                                style: const TextStyle(
                                                    color: Colors.black),
                                                hint: selectedCity == null
                                                    ? const Text('Pilih Kota')
                                                    : Text(selectedCity.cityName),
                                                items: snapshot.data!.map<
                                                        DropdownMenuItem<City>>(
                                                    (City value) {
                                                  return DropdownMenuItem(
                                                      value: value,
                                                      child: Text(value.cityName
                                                          .toString()));
                                                }).toList(),
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    selectedCity = newValue;
                                                  });
                                                });
                                          } else if (snapshot.hasError) {
                                            return const Text("Tidak ada Data");
                                          }
                                          return UiLoading.loadingDD();
                                        }),
                                  )
                                ],
                              )),
                        ],
                      ),

                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Destination",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            )),
                      ),

                      //Destination Provinsi
                      Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 150,
                                    child: FutureBuilder<List<Province>>(
                                        future: provinceData,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return DropdownButton(
                                                isExpanded: true,
                                                value: selectedProv2,
                                                icon: const Icon(
                                                    Icons.arrow_drop_down),
                                                iconSize: 30,
                                                elevation: 16,
                                                style: const TextStyle(
                                                    color: Colors.black),
                                                hint: selectedProv2 == null
                                                    ? const Text('Pilih Provinsi')
                                                    : Text(selectedProv2.province),
                                                items: snapshot.data!.map<
                                                        DropdownMenuItem<Province>>(
                                                    (Province value) {
                                                  return DropdownMenuItem(
                                                      value: value,
                                                      child: Text(value.province
                                                          .toString()));
                                                }).toList(),
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    selectedProv2 = newValue;
                                                    provId2 =
                                                        selectedProv2.provinceId;
                                                  });
                                                  selectedCity2 = null;
                                                  cityData2 = getCities(provId2);
                                                });
                                          } else if (snapshot.hasError) {
                                            return const Text("Tidak ada Data");
                                          }
                                          return UiLoading.loadingDD();
                                        }),
                                  )
                                ],
                              )),

                              //Destination City
                              Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: selectedProv2 == null ? 
                                const Text("Pilih Provinsi Dulu!") : 
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 150,
                                    child: FutureBuilder<List<City>>(
                                        future: cityData2,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return DropdownButton(
                                                isExpanded: true,
                                                value: selectedCity2,
                                                icon: const Icon(
                                                    Icons.arrow_drop_down),
                                                iconSize: 30,
                                                elevation: 16,
                                                style: const TextStyle(
                                                    color: Colors.black),
                                                hint: selectedCity2 == null
                                                    ? const Text('Pilih Kota')
                                                    : Text(selectedCity2.cityName),
                                                items: snapshot.data!.map<
                                                        DropdownMenuItem<City>>(
                                                    (City value) {
                                                  return DropdownMenuItem(
                                                      value: value,
                                                      child: Text(value.cityName
                                                          .toString()));
                                                }).toList(),
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    selectedCity2 = newValue;
                                                  });
                                                });
                                          } else if (snapshot.hasError) {
                                            return const Text("Tidak ada Data");
                                          }
                                          return UiLoading.loadingDD();
                                        }),
                                  )
                                ],
                              )),
                        ],
                      )
                    ]),
                  ),

                  ElevatedButton(
                    child: const Text("Hitung Estimasi Harga"),
                    onPressed: (){
                      if(selectedCity == null || selectedCity2 == null){
                        Fluttertoast.showToast(msg: "Origin dan atau Destination masih belum diset!");
                      }else{
                        Fluttertoast.showToast(msg: "Origin: " + selectedCity.cityName + ", " + "Destination: " + selectedCity2.cityName);
                      }
                    },
                  ),

                  //Flexible untuk nampilin data
                  Flexible(
                    flex: 2,
                    child: Container(),
                  )
                ],
              )),
          isLoading == true ? UiLoading.loadingBlock() : Container()
        ],
      ),
    );
  }
}
