pragma solidity ^0.4.22;
import "./Ownable.sol";

contract Subscription is Ownable {

    struct Funder {
        address addr;
        uint amount;
    }

    struct SubscriptionModel {
        uint numCollected;
        uint subscriptionStart;
        address buyer;
        uint remainingFunds;
    }

    bool public cancellable;
    uint public unitPrice;
    uint public numPayments;
    uint public unitTime;

    mapping (address => Subscription) subscribers;
    address[] subscriberAddresses;

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
        require(subscribers[msg.sender].subscriptionStart == 0);
        SubscriptionModel storage newSub = subscribers[msg.sender];
        newSub.subscriptionStart = now;
        newSub.buyer = msg.sender;
        newSub.remainingFunds = msg.value;

        subscriberAddresses.push(msg.sender);

        emit SubscriptionStarted(unitPrice * numPayments, numPayments, cancellable, buyer);
    }

    function collectSubscription() public onlyOwner {
        require(subscriptionStart != 0);
        require(numCollected < numPayments);
        require(now >= subscriptionStart + (unitTime * numCollected));

        for (uint i=0; i<subscriberAddresses.length; i++) {
            SubscriptionModel storage sub = subscribers[subscriberAddresses[i]];
            if ((sub.subscriptionStart != 0) && (now >= sub.subscriptionStart + (unitTime * sub.numCollected)) && (sub.numCollected < numPayments)) {
                sub.numCollected++;
                sub.remainingFunds -= unitPrice;
                owner.transfer(unitPrice);
                emit SubscriptionCharged(unitPrice, sub.buyer);
            }
        }


    }

    function cancelSubscription() public {
        SubscriptionModel storage sub = subscribers[msg.sender];
        require(msg.sender == sub.buyer);
        require(cancellable);

        // TODO: fix remaining balance
        sub.remainingBalance = 0;
        sub.buyer.transfer(sub.remainingBalance);

        delete subscribers[msg.sender];
    }

    function checkSubscription(address _buyer) public constant returns (uint _remainingFunds, uint _numCollected, uint _subscriptionStart) {
        SubscriptionModel memory sub = subscribers[msg.sender];
        _remainingFunds = sub.remainingFunds;
        _numCollected = sub.numCollected;
        _subscriptionStart = sub.subscriptionStart;
    }

}