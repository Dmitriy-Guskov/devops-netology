Memory
100 * (1 - ((avg_over_time(node_memory_MemFree_bytes{job=~"nodeexporter"}[30d]) + avg_over_time(node_memory_Cached_bytes{job=~"nodeexporter"}[30d]) + avg_over_time(node_memory_Buffers_bytes{job=~"nodeexporter"}[30d])) / avg_over_time(node_memory_MemTotal_bytes{job=~"nodeexporter"}[30d])))
CPU
100 - (avg by (instance) (rate(node_cpu_seconds_total{job="nodeexporter",mode="idle"}[1m])) * 100)
CPU 1/5/15
100 - (avg by (instance) (rate(node_cpu_seconds_total{job="nodeexporter",mode="idle"}[1m])) * 100)
100 - (avg by (instance) (rate(node_cpu_seconds_total{job="nodeexporter",mode="idle"}[5m])) * 100)
100 - (avg by (instance) (rate(node_cpu_seconds_total{job="nodeexporter",mode="idle"}[15m])) * 100)
Disk
100 - (100 * ((node_filesystem_avail_bytes{mountpoint="/",fstype!="rootfs"} )  / (node_filesystem_size_bytes{mountpoint="/",fstype!="rootfs"}) ))
