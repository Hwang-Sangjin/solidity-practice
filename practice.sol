//pragma solidity >=0.4.24 <=0.5.6;

contract Practice {
    string public name = "KlayLion";

    string public symbol = "KL";

    mapping (uint256 => address) public tokenOwner;
    mapping (uint256 => string) public tokenURIs;

    //소유한 토큰 리스트
    mapping(address => uint256[]) private _ownedTokens;

    //mint(tokenId, uri, owner)
    //transferFrom(from, to, tokenId) -> owner가 바뀌는 것 (from -> to)

    function mintWithTokenURI(address to, uint256 tokenId, string memory tokenURI) public returns (bool){
        //to 에게 tokenID를 발행하겠다.
        //적힐 글자는 tokenURI
        tokenOwner[tokenId] = to;
        tokenURIs[tokenId] = tokenURI;

        //add token to the List
        _ownedTokens[to].push(tokenId);

        return true;
    }

    function safeTransferFrom(address from, address to, uint256 tokenId) public{
        require(from == msg.sender, "from !=msg.sender");
        require(from == tokenOwner[tokenId], "you are not the owner of the token");
        
        _removeTokenFromList(from, tokenId);
        tokenOwner[tokenId] = to;
        _ownedTokens[to].push(tokenId);
    }
    function _removeTokenFromList(address from, uint256 tokenId) private{
        //swap last token with deleting token
        uint256 lastTokenIdex = _ownedTokens[from].length - 1;
        for (uint256 i = 0; i < _ownedTokens[from].length; i++) {
            if (tokenId == _ownedTokens[from][i]) {
                // Swap last token with deleting token;
                _ownedTokens[from][i] = _ownedTokens[from][lastTokenIdex];
                _ownedTokens[from][lastTokenIdex] = tokenId;
                break;
            }
        }
        _ownedTokens[from].pop();
    }

    function ownedTokens(address owner) public view returns(uint256[] memory){
        return _ownedTokens[owner];
    }

    function setTokenUri (uint256 id, string memory uri) public {
        tokenURIs[id] = uri;
    }
}