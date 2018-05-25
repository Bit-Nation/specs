# Dapp Specifications

## Simple Auction
To initialize the simple auction smart contract just create the Smart contract with the following parameters:
1. `Duration`: How long the auction will last in seconds starting from now.
2. `Beneficiary`: The person who's receiving the ether after the auction ends.

The auction contract exposes 3 functions.

`bid()`: Callable without any parameters, just sent from the bidder with a value attached to the transaction.
The value must be higher than the current highest bid.

`withdraw()`: Callable without any parameters, by any bidder to withdraw a bid that was overbid.

`auctionEnd()`: Callable without any parameters, ends the auction and sends the funds to the beneficiary specified when creating the contract.

## One Time Purchase
To initialize the OneTimePurchase smart contract pass in the following parameters when creating the smart contract:
1. `Price`: How much is the product going to be sold for? (Price in wei)
2. `Description`: A short description describing the product being sold.
3. `Seller`: Who is selling the product? This address will be able to withdraw the funds from the contract.

The contract exposes 4 functions.
`buyItem()`: Callable without any parameters, just sent from the buyer with the sell price attached as the value in the transaction.
Call will fail if there is not enough ether sent.

`withdraw()`: Callable without any parameters, withdraws all the ether stored in the contract to the seller's ethereum address.

`endSale()`: Callable without any parameters and by the seller only. Destroys the sale contract and sends all remaining ether to the seller.

`checkCustomer(address customer)`: Callable by passing the ethereum address of the customer being checked. This will return an uint of the number of times
this customer has purchased this item.

## Subscription
The subscription contract is initialized with the following parameters:
1. `unitPrice`: How much does the subscription cost per charge? (eg. 1 ETH per month)
2. `numPayments`: How many payments does the subscription constitute?
3. `cancellable`: Is the subscription cancellable?
4. `unitTime`: How often is the subscription charged in seconds? (eg. 2629746 for monthly charge)

The contract exposes 3 functions.
`buySubscription()`: Callable without any parameters, and must be sent from the buyer with the full amount required for the subscription.
Eg. If the subscription costs 1 ETH for 12 months, 12 ETH must be sent with the call.

`collectSubscription()`: Callable without any parameters from the owner. Collects all the available subscriptions

`cancelSubscription()`: Callable without any parameters from a subscription buyer. Requires subscription to be cancellable. Refunds all remaining 
funds in that subscription back to the buyer.