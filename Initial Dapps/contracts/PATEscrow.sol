//
// A contract for running an escrow service for Ethereum token-contracts
//
// Supports the "standardized token API" as described in https://github.com/ethereum/wiki/wiki/Standardized_Contract_APIs
//
// To create an escrow request, follow these steps:
// 1. Call the create() method for setup
// 2. Transfer the tokens to the escrow contract
//
// The recipient can make a simple Ether transfer to get the tokens released to his address.
//
// The buyer pays all the fees (including gas).
//

contract IToken {
    function balanceOf(address _address) constant returns (uint balance);
    function transfer(address _to, uint _value) returns (bool success);
}

contract PatEscrow {
    address owner;
    address buyer;
    address token;           // address of the token contract
    uint tokenAmount;        // number of tokens requested
    uint price;              // price to be paid by buyer

    modifier owneronly { if (msg.sender == owner) _; }
    function setOwner(address _owner) owneronly {
        owner = _owner;
    }

    function PatEscrow(address _token, uint _price, uint _tokenAmount, address _buyer) {
        owner = msg.sender;
        token = _token;
        price = _price;
        tokenAmount = _tokenAmount;
    }

    // Incoming transfer from the buyer
    function() {

        IToken token = IToken(token);

        // Check the token contract if we have been issued tokens already
        uint balance = token.balanceOf(this);

        require(balance == tokenAmount);
        require(msg.value == price);

        // Transfer tokens to buyer
        token.transfer(buyer, tokenAmount);

        // Transfer money to seller
        owner.transfer(price);

    }
}