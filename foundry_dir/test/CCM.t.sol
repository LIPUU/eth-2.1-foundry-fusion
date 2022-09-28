// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
import "test/helper.sol";

contract CCMTest is Test {
    address deployer=vm.addr(1);
    address addr1=vm.addr(11);
    address addr2=vm.addr(0x64);
    address eccd;
    address factory;
    address callerp;
    address calleriMock;
    address ccmp;
    address ccmi;
    
    address msgGenerator;
    address ethSignMsgGenerator;
    function setUp() public {
        vm.prank(deployer);
        eccd= deployCode("EthCrossChainData.sol");
        
        vm.prank(deployer);
        factory= deployCode("CallerFactory.sol",abi.encode(new address[](0)));
        
        ccmi = deployCode("EthCrossChainManagerImplementation.sol");

        ccmp=deployCode("EthCrossChainManager.sol",abi.encode(ccmi,deployer,""));
        
        require(IEthCrossChainData(eccd).owner()==deployer);
        vm.prank(deployer); 
        IEthCrossChainData(eccd).transferOwnership(ccmp);
        require(IEthCrossChainData(eccd).owner()==ccmp);
        
        calleriMock=deployCode("callerMock.sol:CallerImplementationMock");
        msgGenerator=deployCode("callerMock.sol:CallerSigMsgGen");
        ethSignMsgGenerator=deployCode("callerMock.sol:EthSigMsgGen");

        callerp=ICallerFactory(factory).deploy(111,calleriMock,addr1,abi.encodeWithSelector(bytes4(keccak256("initialize(address)")),ccmp));

        // console.log("eccd address: %s",eccd);
        // console.log("callerp address: %s",factory);
    }

    function testDeployCaller() public {
        uint salt=777;
        address preCalcAddress=ICallerFactory(factory).getDeploymentAddress(salt,addr1);
        require(!ICallerFactory(factory).isChild(preCalcAddress));
        
        vm.prank(addr1);
        ICallerFactory(factory).deploy(salt,calleriMock,addr1,abi.encodeWithSelector(bytes4(keccak256("initialize(address)")),ccmp));
        require(ICallerFactory(factory).isChild(preCalcAddress));
        require(!ICallerFactory(factory).isChild(ccmp));
        require(ICallerImplementationMock(preCalcAddress).whoAmI()==1);
    }

    function testDeployCallerWithSignature() public {
        uint salt=1234;
        address logic=calleriMock;
        address admin=addr2;
        address signer = addr2;
        bytes memory data= abi.encodeWithSelector(bytes4(keccak256("initialize(address)")),ccmp);
        bytes32  msgNeededToSign = ICallerSigMsgGen(msgGenerator).getSigMsg(salt,logic,admin,data,factory);
        bytes32 newMsgNeededToSign= IEthSigMsgGen(ethSignMsgGenerator).toEthSignedMessageHash(msgNeededToSign);
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(0x64, newMsgNeededToSign);
        bytes memory signature=abi.encodePacked(r,s,v);

        address preCalAddress = ICallerFactory(factory).getDeploymentAddress(salt,signer);
        require(!ICallerFactory(factory).isChild(preCalAddress));
        ICallerFactory(factory).deploySigned(salt,logic,admin,data,signature);
        require(ICallerFactory(factory).isChild(preCalAddress),"preCalAddress is not chid of proxy factory");
    }

    function testCanNotDeployCallerWithFakeSignature() public {
        uint salt=1234;
        uint sale_fake=7890;
        address logic= calleriMock;
        address admin  =addr2;
        address signer = addr2;
        bytes memory data= abi.encodeWithSelector(bytes4(keccak256("initialize(address)")),ccmp);
        bytes32  msgNeededToSign = ICallerSigMsgGen(msgGenerator).getSigMsg(sale_fake,logic,admin,data,factory);
        bytes32 newMsgNeededToSign= IEthSigMsgGen(ethSignMsgGenerator).toEthSignedMessageHash(msgNeededToSign);
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(0x64, newMsgNeededToSign);
        bytes memory signature=abi.encodePacked(r,s,v);

        address preCalAddress = ICallerFactory(factory).getDeploymentAddress(salt,signer);
        require(!ICallerFactory(factory).isChild(preCalAddress));
        ICallerFactory(factory).deploySigned(salt,logic,admin,data,signature);
        require(!ICallerFactory(factory).isChild(preCalAddress),"preCalAddress is not chid of proxy factory");
    }

    function testCallerP_CanNotChangeImplementationByNonAdmin() public {
        vm.expectRevert();
        IEthCrossChainCaller(callerp).upgradeTo(calleriMock);
    }

    function testCallerP_CanChangeImplementationByAdmin() public {
        address calleriMock2=deployCode("callerMock.sol:CallerImplementationMock_2");
        
        vm.prank(addr1);
        IEthCrossChainCaller(callerp).upgradeTo(calleriMock2);
        assertEq(ICallerImplementationMock_2(callerp).whoAmI(),2);
        
        vm.prank(addr1);
        IEthCrossChainCaller(callerp).upgradeTo(calleriMock);
        assertEq(ICallerImplementationMock(callerp).whoAmI(),1);
    }
    
    function testCallerP_CanNotChangeAdminByNonAdmin() public {
        vm.expectRevert();
        IEthCrossChainCaller(callerp).changeAdmin(addr2);
    }

    function testCallerP_CanChangeAdminByAdmin() public {
        vm.prank(addr1);
        IEthCrossChainCaller(callerp).changeAdmin(addr2);

        vm.prank(addr1);
        vm.expectRevert();
        IEthCrossChainCaller(callerp).changeAdmin(addr2);

        vm.prank(addr2);
        IEthCrossChainCaller(callerp).changeAdmin(addr1);
    }
    
    // test eccm

    function testEccmP_CanChangeImplementationByAdmin() public {
        address ccmi2 = deployCode("EthCrossChainManagerImplementation.sol");
        vm.startPrank(deployer);
        IEthCrossChainManager(ccmp).upgradeTo(ccmi2);
        assertEq(ccmi2,IEthCrossChainManager(ccmp).implementation());

        IEthCrossChainManager(ccmp).upgradeTo(ccmi);
        assertEq(ccmi,IEthCrossChainManager(ccmp).implementation());
        
    }

    function testEccmP_CanNotChangeImplementationByNonAdmin() public {
        address ccmi2 = deployCode("EthCrossChainManagerImplementation.sol");
        vm.expectRevert();
        IEthCrossChainManager(ccmp).upgradeTo(ccmi2);
    }

    function testEccmP_CanChangeAdminByAdmin() public {
        vm.prank(deployer);
        IEthCrossChainManager(ccmp).changeAdmin(addr1);

        vm.prank(addr1);
        IEthCrossChainManager(ccmp).changeAdmin(deployer);
    }

    function testEccmP_CanNotChangeAdminByNonAdmin() public {
        vm.expectRevert();
        IEthCrossChainManager(ccmp).changeAdmin(addr1);
    }

    function testCanCallCrossChainFromValidCaller() public {
        bytes memory args="0x123456";
        uint txIndex = IEthCrossChainData(eccd).getEthTxHashIndex();
        assertEq(0,txIndex);
        // console.logBytes32(IEthCrossChainData(eccd).getEthTxHash(txIndex));

        ICallerImplementationMock(callerp).lock(args);
        
        

        uint newTxIndex = IEthCrossChainData(eccd).getEthTxHashIndex();
        assertEq(1,newTxIndex);
        // console.logBytes32(IEthCrossChainData(eccd).getEthTxHash(txIndex));
    }
    
    function testCanNotCallCrossChainFromInvalidCaller() public {
        bytes memory args="0x123456";
        ICallerImplementationMock(calleriMock).initialize(ccmp);
        vm.expectRevert(bytes("call ccm failed"));
        ICallerImplementationMock(calleriMock).lock(args);
    }
    
    // todo
    // function testShouldSuccessInitGenesisblockAtUninitializedCCM() public {
    //     bytes memory rawHeader = "";
    //     assertEq(IEthCrossChainData(eccd).getCurEpochStartHeight(),0);
    //     IEthCrossChainManagerImplementation(ccmi).initGenesisBlock(rawHeader);
    //     assertEq(IEthCrossChainData(eccd).getCurEpochStartHeight(),1000);
    //     console.log(IEthCrossChainData(eccd).getCurEpochValidatorPkBytes());
    // }

    // todo
    // function testShouldFailInitGenesisblockAtInitializedCCM() public {
    //     bytes memory rawHeader = "";
    //     assertEq(IEthCrossChainData(eccd).getCurEpochStartHeight(),0);
    //     IEthCrossChainManagerImplementation(ccmi).initGenesisBlock(rawHeader);
    //     assertEq(IEthCrossChainData(eccd).getCurEpochStartHeight(),1000);
    //     console.log(IEthCrossChainData(eccd).getCurEpochValidatorPkBytes());
    // }
    
    
    
    

}

