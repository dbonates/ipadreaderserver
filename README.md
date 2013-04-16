ipadreaderserver
================

1. Configure file config/deploy.rb with your preferences of server.
2. cap deploy:setup
3. cap deploy:check
4. cap deploy:migrations

próximos deploys:

1. git commit -m mensagem
2. cap deploy

voltar versões / desfazer deploy

1. deploy:rollback

                            

Alterações:
================

rails g migration AddAdminToUsers admin:boolean
rails g migration AddVisibleToMagazines visible:boolean

Magazines -

	Na criação 	- o admin define o user_id
	                                                                       
	* Nessa estratégia talvez seja melhor criar um template pro usuario admin e outro pro comum
	Na listagem - se o usuario for admin, listar todas + todos os controles
				- se for usuario comum, listar as visíveis + mostrar apenas o controle de editar a Revista, Edições e Assinatura
