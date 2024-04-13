// SPDX-License-Identifier:MIT
pragma solidity ^0.8.18;
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";



contract MoodNft is ERC721{

  error MoodNft__CantFlipMoodIfNotOwner();
  uint256 private s_tokenCounter;
  string private s_sadSvgImageUri;
  string private s_happySvgImageUri;

  enum Mood{
    HAPPY,
    SAD
  }

  mapping(uint256 => Mood) s_tokenIdToMood;
  mapping(uint256 => string) s_tokenIdToUri;

  constructor(string memory sadImageUri, string memory happyImageUri) ERC721("Mood NFT", "MN"){
    s_tokenCounter = 0;
    s_sadSvgImageUri = sadImageUri;
    s_happySvgImageUri = happyImageUri;
  }

  function mintNft() public {
    _safeMint(msg.sender, s_tokenCounter);
    s_tokenIdToMood[s_tokenCounter] = Mood.HAPPY;
    s_tokenCounter++;
  }

  function flipMood(uint256 tokenId) internal view  override  returns(bool){
    // only want the NFT owner tobe ableto flip
    if(!_isAuthorized(msg.sender, address(this), tokenId)) {
      revert MoodNft__CantFlipMoodIfNotOwner();
    }
    if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
      return s_tokenIdToMood[tokenId] == Mood.SAD;
    }else{
      return s_tokenIdToMood[tokenId] == Mood.HAPPY;
    }
  }

function _baseURI() internal pure override returns (string memory) {
  return "data:application/json;base64,";
}
  function tokenURI(uint256 tokenId) public view override returns (string memory) {
    string memory imageURI;
    if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
        imageURI = s_happySvgImageUri;
    }else {
      imageURI = s_sadSvgImageUri;
    }

return 
  string(
        abi.encodePacked(
          _baseURI(),
          Base64.encode(
            bytes(abi.encodePacked(
              '{"name":"',name(),
              '", "descreption":"AnNFT that reflects the owners mood.", "attributes": [{"trait_type": "moodiness", "value": 100}], "image":"',imageURI,'"}'
            )
          )
        )
      )
    );
  }
}