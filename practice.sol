//pragma solidity >=0.4.24 <=0.5.6;

contract Practice {
    string public name = "KlayLion";

    string public symbol = "KL";

    mapping (uint256 => address) public tokenOwner;
    mapping (uint256 => string) public tokenURIs;

    //mint(tokenId, uri, owner)
    //transferFrom(from, to, tokenId) -> owner가 바뀌는 것 (from -> to)

    function mintWithTokenURI(address to, uint256 tokenId, string memory tokenURI) public returns (bool){
        //to 에게 tokenID를 발행하겠다.
        //적힐 글자는 tokenURI
        tokenOwner[tokenId] = to;
        tokenURIs[tokenId] = tokenURI;
    }

    function safeTransferFrom(address from, address to, uint256 tokenId) public{
        require(from == msg.sender, "from !=msg.sender");
        require(from == tokenOwner[tokenId], "you are not the owner of the token");
        
        tokenOwner[tokenId] = to;
    }

    function setTokenUri (uint256 id, string memory uri) public {
        tokenURIs[id] = uri;
    }
}