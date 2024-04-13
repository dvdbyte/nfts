// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {Test} from "forge-std/Test.sol";
import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";
import {BasicNft} from "../src/BasicNft.sol";

contract BasicBftTest is Test {
  DeployBasicNft private deployer;
  BasicNft private basicNft;

  address public  USER = makeAddr("user");
  uint256 private constant USER_BALANCE = 5 ether;
  string  public constant PUG = "bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

  function setUp() external {
    deployer = new  DeployBasicNft();
    basicNft = deployer.run();
  }

  function testNameIsCorrect () public view{
    string memory expectedName = "BasicNFT";
    string memory realName = basicNft.name();

    assert (keccak256(abi.encodePacked(expectedName)) == keccak256(abi.encodePacked(realName)));
  }

  function testCanMintAndHaveBalance () public {
    // Arrange
    vm.prank(USER);

    // Act 
    basicNft.mintNft(PUG);

    // Assert
    assert(basicNft.balanceOf(USER) == 1);
    assert(keccak256(abi.encodePacked(PUG)) == keccak256(abi.encodePacked(basicNft.tokenURI(0))));
  }
}

/**
 * Function "mintNft" (location: source ID 36, line 15, chars 324-491, hits: 0)
- Line (location: source ID 36, line 16, chars 380-421, hits: 0)
- Statement (location: source ID 36, line 16, chars 380-421, hits: 0)
- Line (location: source ID 36, line 17, chars 427-464, hits: 0)
- Statement (location: source ID 36, line 17, chars 427-464, hits: 0)
- Line (location: source ID 36, line 18, chars 470-486, hits: 0)
- Statement (location: source ID 36, line 18, chars 470-486, hits: 0)

- Function "tokenURI" (location: source ID 36, line 21, chars 495-616, hits: 0)
- Line (location: source ID 36, line 22, chars 581-611, hits: 0)
- Statement (location: source ID 36, line 22, chars 581-611, hits: 0)
 
 
 * */ 