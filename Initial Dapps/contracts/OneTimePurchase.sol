pragma solidity ^0.4.22;

contract OneTimePurchase {

    uint public price;
    string public description;
    uint public numPurchased;
    address public seller;
    mapping (address => uint) public customers;

    event ItemPurchased(address indexed customer);

    constructor(uint _price, string _description, address _seller) public {
        price = _price;
        description = _description;
        seller = _seller;
    }

    function checkCustomer(address _customer) public view returns (uint _numPurchased) {
        return customers[_customer];
    }

    function buyItem() payable public {
        require(msg.value == price);
        customers[msg.sender] += 1;
        numPurchased += 1;
        emit ItemPurchased(msg.sender);
    }

    function withdraw() public {
        require(address(this).balance > 0);
        require(msg.sender == seller);
        seller.transfer(address(this).balance);
    }

    function endSale() public {
        require(msg.sender == seller);
        selfdestruct(seller);
    }

}