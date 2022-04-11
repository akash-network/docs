# Questions fréquemment posées (FAQ)


### Table des matières
 
[Produit](#Produit) 
[Supermini](#Supermini)   


<a name="Produit"/>

## Produit

**Akash peut-il fournir des services de nom de domaine?**

Le problème pour l'instant pour utiliser Akash en tant que serveur de nom de domaine est que le DNS est exposé sur un port aléatoire au lieu du port 53. A l'avenir cette fontionnalitée pourrait voir le jour.

**Dois-je redéployer si je veux mettre à jour le déploiement?**

Cela dépend de ce que vous souhaitez mettre à jour. Les déploiements Akash sont traduits en déploiements Kubernetes, ce qui signifie que seuls quelques champs du fichier SDL Akash sont modifiables. Par exemple, l'image, les commandes, les arguments, l'environnement et les ports exposés peuvent être modifiés, mais pas les ressources (CPU/RAM/Disque) ni les critères de placement. 

**Comment puis-je (en tant qu'utilisateur d'Akash qui souhaite déployer) être sûr que le fournisseur n'essaiera pas de modifier mon application ?**

Pour l'instant, nous n'avons pas de support pour les enclaves sécurisées. Il existe certaines limitations techniques liées à TEE et autres. Notre système de vérification d'attributs est destiné à aborder le problème sous un angle différent.
Pourquoi feriez-vous confiance à Digital Ocean, à AWS ou à tout autre fournisseur de services cloud en premier lieu ? La fonction de vérification d'attributs vous permet de déployer uniquement sur des fournisseurs qui ont été "approuvés" par une entité en laquelle vous avez confiance. 

**Existe-t-il également un moyen de décentraliser le registre Docker ? Ainsi, il ne s'agirait pas d'un point de défaillance unique, si le registre sélectionné (centralisé) tombe en panne ?**

Oui, c'est quelque chose dont nous parlons depuis longtemps mais que nous n'avons pas eu l'occasion d'approfondir.  Cela pourrait être un logiciel de type bittorrent ou cela pourrait être sur IPFS, etc... Nous avons l'intention d'explorer tout cela, mais nous nous concentrons sur la mise en place de la plate-forme en partant du principe que les conteneurs docker sont plus ou moins accessibles pour le moment.

**Est-il prévu d'ajouter la prise en charge des volumes persistants ?**

Oui. Tout le stockage est éphémère pour le moment, mais nous travaillerons sur le stockage persistant à l'avenir.

**Les GPU sont elles supportées?**

C'est sur la feuille de route, cependant, les workloads GPU ne sont pas encore supportées - il y a quelques limitations techniques liées au partage des GPU et à la sécurité avec notre backend Kubernetes actuel. Nous y travaillons activement.

**Akash peut-il être utilisé avec des images Docker privées ou doivent-elles être publiques ?**

Les images doivent être publiques pour le moment.

<a name="Supermini"/>

## Supermini

**Quand puis-je obtenir le Supermini et peut-il être expédié en dehors des États-Unis ?**

Actuellement, il n'y a pas d'autres informations sur le Supermini, ni sur sa disponibilité aux États-Unis ou en Europe, ni les dates de disponibilité pour les commandes ultérieures. En attendant, n'hésitez pas à vous inscrire sur la liste d'attente ! https://akash.network/supermini/

**Combien d'argent le Supermini peut-il me rapporter ?**

Le rendement d'un Supermini en tant que fournisseur sur le réseau Akash sera en fonction de la demande et de l'utilisation du réseau, c'est-à-dire qu'il dépendra du nombre d'applications déployées sur le réseau. Nous nous concentrons sur le développement de cette demande dans les mois à venir.
