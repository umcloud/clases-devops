SHELL=/bin/bash
help:
	@echo "make apply"
	@echo "make load-sql"
	@echo "make query-sql"
	@echo "make delete"
	@echo "make delete-pvc"

apply:
	kubectl apply -f mariadb-galera.MariaDB.yaml

load-sql:
	. ./load-secrets.sh && kubectl exec -it mariadb-galera-2 -- mariadb -uroot -p"$$SECRET" < personas.sql

query-sql:
	. ./load-secrets.sh && kubectl exec -it mariadb-galera-0 -- mariadb -uroot -p"$$SECRET" -e "select * from persona_db.personas"
	. ./load-secrets.sh && for i in mariadb-galera-{0..2}; do echo ===$$i===; kubectl exec -it $$i -- mariadb -uroot -p"$$SECRET" -e "select count(*) from persona_db.personas"; done

delete:
	kubectl delete -f mariadb-galera.MariaDB.yaml

delete-pvc:
	kubectl delete pvc -l app.kubernetes.io/instance=mariadb-galera,app.kubernetes.io/name=mariadb

.PHONY: help apply load-sql query-sql delete delete-pvc
