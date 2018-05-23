pragma solidity ^0.4.22;
import "./Ownable.sol";

contract Subscription is Ownable {

    uint public unitPrice;
    uint public numPayments;
    uint public numCollected;
    bool public cancellable;
    uint public subscriptionStart;
    uint public unitTime;
    address public buyer;

    event SubscriptionCharged(uint amount, address buyer);
    event SubscriptionStarted(uint totalAmount, uint numPayments, bool cancellable, address buyer);
    event SubscriptionEnded(uint totalAmount, address buyer);

    constructor(uint _unitPrice, uint _numPayments, bool _cancellable, uint _unitTime) public {
        unitPrice = _unitPrice;
        numPayments = _numPayments;
        cancellable = _cancellable;
        unitTime = _unitTime;
    }

    function buySubscription() public payable {
        require(msg.value == unitPrice * numPayments);
        require(subscriptionStart == 0);
        subscriptionStart = now;
        buyer = msg.sender;

        emit SubscriptionStarted(unitPrice * numPayments, numPayments, cancellable, buyer);
    }

    function collectSubscription() public onlyOwner {
        require(subscriptionStart != 0);
        require(numCollected < numPayments);
        require(now >= subscriptionStart + (unitTime * numCollected));

        numCollected++;

        owner.transfer(unitPrice);

        emit SubscriptionCharged(unitPrice, buyer);

    }

    function cancelSubscription() public {
        require(msg.sender == buyer);
        require(cancellable);

        buyer.transfer(address(this).balance);
    }

}