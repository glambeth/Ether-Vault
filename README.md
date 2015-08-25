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

6)
```
var vault = vaultContract.new({from: web3.eth.accounts[0], data: vaultCompiled.timeVault.code, gas: 300000}, function(e, contract) {
	if (!e) {
		if (!contract.address) {
			console.log("Contract transaction send: TransactionHash: " + contract.transactionHash + "Waiting to be mined..")
		} else {
			console.log("Contract mined! Address: " + contract.address);
			console.log(contract);
		}
	}
});
```

7) Now the contract should be mined. Time for the fun stuff! Let's send some assets to the vault.
```
> vault.sendAssets( 10, {from: eth.accounts[0], to: vault.address, vaule: 20})
```
This would store 20 wei and would be avaliable after block number 10 has been mined. 
