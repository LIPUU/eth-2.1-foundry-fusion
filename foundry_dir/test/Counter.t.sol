// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "forge-std/console.sol";

contract CCMTest is Test {
    address deployer=vm.addr(1);
    address add1=vm.addr(11);
    address add2=vm.addr(111);
    address eccd;
    address factory;
    function setUp() public {
        eccd= deployCode("EthCrossChainData.sol");
        factory= deployCode("CallerFactory.sol",abi.encode(new address[](0)));
        
    }

    function testC()  public {
        
    }


}
