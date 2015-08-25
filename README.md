# Ether-Vault
Keep your ether safe for n blocks

#Getting Started
1) Open up geth

2) 
```
var vaultSource = 'contract timeVault { struct Member { address addr; uint amount; uint blockNumberDeposited; uint blockWithdrawlNumber; } Member[] public members; uint public fundsStored; uint public numDeposits; function timeVault() { fundsStored = 0; numDeposits = 0; } function sendAssets(uint blockWithDrawlNumber) { Member newMember; newMember.addr = msg.sender; newMember.amount = msg.value; newMember.blockNumberDeposited = block.number; newMember.blockWithdrawlNumber = blockWithDrawlNumber; members[numDeposits] = newMember; numDeposits++; } function retrieveAssets() { for (uint i =0; i < numDeposits; ++i) { if (members[i].blockWithdrawlNumber >= block.number) { members[i].addr.send(members[i].amount); } } } }'
```
3) Ensure Solidity is installed. If not, follow instructions at www.ethereum.org/greeter

4) 
```
var vaultCompiled = web3.eth.compile.solidity(vaultSource)
```

5) 
```
var vaultContract = web3.eth.contract(vaultCompiled.timeVault.info.abiDefinition)
```
