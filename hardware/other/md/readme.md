Шаблон работает на основе утилиты mdadm. Список MD массивов определяется автоматически. В шаблоне 2 элемента данных, 10 прототипов элементов данных и 12 прототипов триггеров.<br>
Я читал мануал ядра Linux, но так и не смог определить все варианты статусов MD массива, которые выводятся утилитой mdadm, поэтому точно определяю статусы active и clean, в другом случае сработает триггер.<br>
Можно добавлять свои статусы, чтобы избавиться от ложных срабатываний.


Качаем шаблон

https://github.com/akgitlab/templates/tree/main/hardware/other/md


Импортируем шаблон zbx5_mdadm_linux.xml и назначаем хостам.

В макросах шаблона можно отредактировать периодичность опроса данных:

* {$MD_DISCOVERY_PERIOD} — 1h. Периодичность автообнаружения массивов<br>
* {$MD_HISTORY_PERIOD} — 30d. Срок хранения истории<br>
* {$MD_HOT_PERIOD} — 5m. Периодичность опроса важных данных<br>
* {$MD_LONG_PERIOD} — 1h. Периодичность опроса данных, которые нужно получать не часто<br>
* {$MD_SHORT_PERIOD} — 10m. Периодичность опроса данных<br>
* {$MD_TREND_PERIOD} — 180d. Срок хранения трендов<br>


На серверах, которые собираемся мониторить, установим mdadm

 shell> apt install mdadm

или

 shell> yum install mdadm


Копируем md.conf в папку с пользовательскими переменными в /etc/zabbix/zabbix_agentd.d/md.conf

Меняем владельца и права:

 shell> chown root\: /etc/zabbix/zabbix_agentd.d/md.conf<br>
 shell> chmod 644 /etc/zabbix/zabbix_agentd.d/md.conf<br>


Копируем папку со скриптами в /etc/zabbix/scripts/. В ней у нас

/etc/zabbix/scripts/md_active_devices.sh<br>
/etc/zabbix/scripts/md_array_size.sh<br>
/etc/zabbix/scripts/md_failed_devices.sh<br>
/etc/zabbix/scripts/md_raid_devices.sh<br>
/etc/zabbix/scripts/md_raid_level.sh<br>
/etc/zabbix/scripts/md_spare_devices.sh<br>
/etc/zabbix/scripts/md_state.sh<br>
/etc/zabbix/scripts/md_total_devices.sh<br>
/etc/zabbix/scripts/md_used_dev_size.sh<br>
/etc/zabbix/scripts/md_working_devices.sh<br>


Не забываем про владельца и права

 shell> chown -R root\: /etc/zabbix/scripts<br>
 shell> chmod a+x /etc/zabbix/scripts/*<br>


Копируем sudoers_zabbix_md в /etc/sudoers.d. Не забываем про владельца и права:

 shell> chown root\: /etc/sudoers.d/sudoers_zabbix_md<br>
 shell> chmod 644 /etc/sudoers.d/sudoers_zabbix_md<br>


Перезапускаем агент

 shell> service zabbix-agent restart
