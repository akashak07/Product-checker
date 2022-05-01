pragma solidity ^0.5.6;

contract Product{
    string public pname;
    string public mdate;
    string public price;
    string public location;

    constructor() public {
            pname;
            mdate;
            price;
            location;
        }


    function setname(string memory _name) public{
        pname=_name;

    }
    function setdate(string memory _mdate) public{

        mdate=_mdate;

    }
    function setloca(string memory _loc) public{

        location=_loc;

    }
    function setprice(string memory _price) public{

        price=_price;
    }


}