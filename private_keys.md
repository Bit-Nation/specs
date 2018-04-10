# Pangea Technical Specification - Key's (WIP)
> Since we use a LOT of private and public key's we somehow need to be able to organise / handle them. Another important point is maintenance. What happen's if an device get's lost? How do we import private key's? The amount of them is growing over time, as we e.g. add new crypto currencies like bitcoin etc which require there own private key.

### Mnemonic
The "mnemonic" is a 24 mnemonic as specified in BIP39. In the context of pangea we are always referencing to a 24 long mnemonic. 24 words are suggested by BIP39. The mnemotic build the "root" key for all pangea private / public key pairs (the ethereum key etc is derived based on the definiton you will find in this document).

### BIP32 - Hardened key derivation
> Since BIP32 doesn't specifiy a derivation function (as pseudo code - way's how to derive key's are described) we will have our own one based on BIP32.

__definition__
`pow(a, b)` takes `a` to the power of `b`

__Description__
We use BIP32 to generate wallet private key's based on the `coin seed` (next element). Only hardened key's are used. The derivation path should look like this `m/100H/10H`. `H` indicates that it's a hardned key. E.g. `m/100H/10H` would be the same as `m/100+pow(2, 31)/10+pow(2, 31)`. When a path segement does not contain an `H` the derivation function should exit with and error. The first segment of the path segments MUST be an `m` which indicates we are deriving from the master key.

### Coin Seed
The coin seed is generated with the BIP39 seed function. Chose the mnemonic as the mnemonic and `coins` as the password to derive the seed for the coins.

### Signal
> TBD

### Mesh
> TBD

### Ethereum Private Key
The ethereum private key is derived via BIP32 and the `coin seed`.  The derivation path is `m/100H/10H`

### Key Storage
All the key's will be stored in the normal file system / database of the device. They must be encrypted with AES256. The encryption "password" for AES256 should be derived with Scrypt from a password the user chose. The key storage will only safe the mnemonic and the derived key's. When implementing this, make sure your implementation provideds data integrety for the key's. E.g. when you derived the ethereum private key and safed it to the key store, make sure to derive it again the next time the client is started and compare it with the safed one in order to fail early in case the process of deriving them changed (I just want to notice that the way of derivation is not supposed to change, the comparison of the stored one and derived one is more to be absolutely sure that it's still the same).

_Fields of the key storage V1_
```
//Example
{
    mnemonic: "string",
    keys: {
        eth_private_key: "string"
    }
    version: 1
}
```

All fields must be represented in JSON. The JSON will be converted to a string and then be encrypted with AES256.

_Scrypt Params to use for the key storage_
- N = 16384
- r = 8
- p = 1


## References
- [BIP39](https://github.com/bitcoin/bips/blob/master/bip-0032.mediawiki)
- [BIP32](https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki)

## Notes
- We only use hardned key's (see bip39) since they are more secure.
- When using the BIP39 seed function it's common pratice to use different passwords to generate different seed's with the same mnemonic. So same menemotic but different passwords. However, the reason why we use the seed function is, to generate deterministic cryptographic secure byte arrays. All "password's" (e.g `coins`) are public and specified. BUT the mnemonic is still unknown so security is given.
