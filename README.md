# ipadreaderserver

### Configure file config/deploy.rb with your preferences of server.
> cap deploy:setup <br />
> cap deploy:check <br />
> cap deploy:migrations

### próximos deploys:

> git commit -m mensagem <br />
> cap deploy

### voltar versões / desfazer deploy

> deploy:rollback

                            

Alterações:
================

rails g migration AddAdminToUsers admin:boolean
rails g migration AddVisibleToMagazines visible:boolean

Magazines -

	Na criação 	- o admin define o user_id
	                                                                       
	* Nessa estratégia talvez seja melhor criar um template pro usuario admin e outro pro comum
	Na listagem - se o usuario for admin, listar todas + todos os controles
				- se for usuario comum, listar as visíveis + mostrar apenas o controle de editar a Revista, Edições e Assinatura
