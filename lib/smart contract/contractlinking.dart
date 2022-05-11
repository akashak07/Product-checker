import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';


class ContractLink extends ChangeNotifier{

  final String _rpcURl = "HTTP://192.168.168.43:7545";
  final String _wsURl = "ws://192.168.168.43:7545/";
  final String _privateKey =
      "9d5bbb1497f34302a7a9fae890757493bc10d18e8beb4aa4882291e66a7d61e8";
  late Web3Client _client;
  late String _abiCode;
  late EthereumAddress _contractAddress;
  late Credentials _credentials;

  bool isLoading = true;
  String? deployedname;
  String? deployeprice;
  String? deployedloca;
  String? deployeddate;




  late DeployedContract contract;
  late ContractFunction pname;
  late ContractFunction mdate;
  late ContractFunction price;
  late ContractFunction location;
  late ContractFunction setname;
  late ContractFunction setdate;
  late ContractFunction setloca;
  late ContractFunction setprice;



  ContractLink(){
    initialSetup();
  }

  initialSetup() async {
    // establish a connection to the ethereum rpc node. The socketConnector
    // property allows more efficient event streams over websocket instead of
    // http-polls. However, the socketConnector property is experimental.
    _client = Web3Client(_rpcURl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsURl).cast<String>();
    });

    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    // Reading the contract abi
    String abiStringFile =
    await rootBundle.loadString("src/artifacts/Product.json");
    var jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi["abi"]);
    // print(_abiCode);

    _contractAddress =
        EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
    // print(_contractAddress);
  }
  Future<void> getCredentials() async {
    _credentials = EthPrivateKey.fromHex(_privateKey);
    // print(_credentials);
  }

  Future<void> getDeployedContract() async {
    // Telling Web3dart where our contract is declared.
    contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "HelloWorld"), _contractAddress);

    // Extracting the functions, declared in contract.
    setname = contract.function('setname');
    setdate = contract.function('setdate');
    setloca = contract.function('setloca');
    setprice = contract.function('setprice');
    pname=contract.function('pname');
    mdate=contract.function('mdate');
    price=contract.function('price');
    location=contract.function('location');
    getname();
  }



  Future<void>addname(String proname) async{
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
      Transaction.callContract(contract: contract, function: setname, parameters: [proname])
    );
    getname();
  }

  Future<void>getname() async{
    var currentname=await _client.call(contract: contract, function: pname, params: []);
    deployedname=currentname[0];
    print("$currentname");
    isLoading=false;
    notifyListeners();
  }

  Future<void>addprice(String proprice) async{
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(contract: contract, function: setprice, parameters: [proprice])
    );
    getprice();
  }

  Future<void>getprice() async{
    var currentprice=await _client.call(contract: contract, function: price, params: []);
    deployeprice=currentprice[0];
    print("$currentprice");
    isLoading=false;
    notifyListeners();
  }

  Future<void>addlocation(String proloca) async{
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(contract: contract, function: setloca, parameters: [proloca])
    );
    getlocation();
  }

  Future<void>getlocation() async{
    var currentloca=await _client.call(contract: contract, function: location, params: []);
    deployedloca=currentloca[0];
    print("$currentloca");
    isLoading=false;
    notifyListeners();
  }

  Future<void>adddate(String prodate) async{
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(contract: contract, function: setdate, parameters: [prodate])
    );
    getdate();
  }

  Future<void>getdate() async{
    var currentloca=await _client.call(contract: contract, function: mdate, params: []);
    deployedloca=currentloca[0];
    print("$currentloca");
    isLoading=false;
    notifyListeners();
  }

}





