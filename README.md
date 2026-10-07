# ImmortalWrt-ImageBuilder

基于 ImageBuilder，通过 GitHub Actions 构建定制的 ImmortalWrt x86_64 固件，适用于 `x86/64 generic` 设备。

## 主要功能

- **自动构建**：支持指定 ImmortalWrt 版本；留空时选择默认 `25.12` 系列的最新正式版。
- **镜像选择**：支持仅生成 ext4 UEFI 镜像，或生成多种磁盘、虚拟机镜像及 rootfs 归档；RootFS 分区大小可配置，默认 `2000 MiB`。
- **构建产物与发布**：自动上传固件和构建记录，支持选择发布到 GitHub Release。
- **中文界面**：预装 Argon 主题及中文界面，调整 LuCI 菜单分类、服务排序。
- **代理与组网**：预装 Nikki，构建时将内核替换为最新稳定版 Mihomo 内核。
- **下载与文件服务**：将 qBittorrent 替换为 qBittorrent Enhanced Edition，并新增 LuCI 在线更新页面。
- **Docker 支持**：预装 Dockerman 和 Docker Compose；挂载 ext4 的 `/overlay` 时将 `/overlay/docker` 绑定至 `/opt/docker`；未挂载时直接使用位于可写 ext4 文件系统上的 `/opt/docker`，启动前检查挂载和存储配置，并配置 LAN 访问容器发布端口的防火墙规则。
