
# Better version of qb-blackmarket
My edit of the https://github.com/krrm1/qb-blackmarket
I fixed some bugs like:buying without money, not getting mail etc

VPN has been removed now once used idea by https://github.com/nzkfc 



add to qb-core/shared/items

```
	['vpn'] 			 	 	     = {['name'] = 'vpn', 			  		        ['label'] = 'vpn', 					    ['weight'] = 700, 		['type'] = 'item', 		['image'] = 'vpn.png', 				    ['unique'] = true, 		['useable'] = false, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'vpn for good use'},
	['darklaptop'] 			 	 	 = {['name'] = 'darklaptop', 			  		['label'] = 'Laptop', 					['weight'] = 700, 		['type'] = 'item', 		['image'] = 'laptop.png', 				['unique'] = true, 		['useable'] = true, 	['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'this laptop need vpn to make it work'},

```
![vpn](https://user-images.githubusercontent.com/89742984/190626872-e76710fb-ca0a-4231-9e0d-137bb909cb1c.png)
