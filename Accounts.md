### Definition
Let's call a person that uses the app a _user_.

Usually, to be able to understand which user is using an app (and therefore provide user-specific information) one gives user an ability to create an account. But our concept is a bit different, we allow user to create multiple _accounts_, therefore we don't have _user-specific_ information, but only _account-specific_ one. 

So, let's be clear in our definition and use term _user_ for a person that uses the app and term _account_ for one of representations of _user_ in the app.

### Technical representation
From technical point of view an account is a root private key. It's completely independent from all other account private keys. 

That root private key is the only one key, that claims _user_ ownership of _account_, so to have that key means to have an account and vice versa. Root private key is used to derive private keys for different needs like ethereum wallet private key, etc. 

### Switching between accounts

User is allowed to create multiple accounts and therefore needs an ability to switch between them. 

Since entering private key is a long process, user should do that only once to create/restore account. Switching between accounts should be simpler, but at the same moment quite secure. In order to achieve that app gives user an ability (and actually an obligation) to setup a password or pin code for each account. That is required since it's used to encrypt private key data before saving it to file system. 

So, to switch to specific account user needs to enter password (or pin code), assuming that that account private key is already stored on user's device.

It's worth noting that password (pin code) protection is completely local and is related only to specific instance of the app installed on the specific device.

### Password (pin code) requirements

TBD

### Account backup

In order to simplify transferring accounts across devices, to provide ability to save your account in a safe place and to give users and alternative to entering the whole private key by hand, the functionality of backing up an account is given. 

Technically that means to export your private key information encrypted by your password somewhere (to another device, PC, etc). 

