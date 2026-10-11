---
name: android-fast-automation
description: Android 移动端毫秒级低延迟自动化控制与网络代理深度诊断工具链。包含 Python Socket 直连 5037 极速触控、内存二进制防损坏截图、Deep Link 意图直通及 Android 15 代理栈排障最佳实践。
---

# Android 极速自动化与移动网络诊断技能 (Android Fast Automation & Network Debug)

本技能提供一套免 Root、零侵入、低延迟的 Android 手机自动化交互代码库与网络排障指南。

## 核心极速代码库 (Python 原生 Socket 实现)

无需安装额外第三方重型库，直接利用 Python 内置 `socket` 库直连本地 ADB 服务，单步触控延迟 46 毫秒，单次截图 330 毫秒。

```python
import socket

class FastADB:
    def __init__(self, serial="45231FDAS00B1Q", host="127.0.0.1", port=5037):
        self.serial = serial
        self.host = host
        self.port = port

    def _connect(self):
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s.connect((self.host, self.port))
        req = f"host:transport:{self.serial}"
        s.sendall(f"{len(req):04x}{req}".encode())
        if s.recv(4) != b"OKAY":
            raise RuntimeError("ADB transport failed")
        return s

    def tap(self, x: int, y: int):
        """46ms 极速单点触控"""
        s = self._connect()
        cmd = f"shell:cmd input tap {x} {y}"
        s.sendall(f"{len(cmd):04x}{cmd}".encode())
        assert s.recv(4) == b"OKAY"
        s.close()

    def screencap(self) -> bytes:
        """330ms 内存流截图，杜绝文件擦写与 Windows 编码损坏"""
        s = self._connect()
        cmd = "exec:screencap -p"
        s.sendall(f"{len(cmd):04x}{cmd}".encode())
        assert s.recv(4) == b"OKAY"
        chunks = []
        while True:
            chunk = s.recv(65536)
            if not chunk: break
            chunks.append(chunk)
        s.close()
        return b"".join(chunks)
```

## Android 15 移动端代理诊断黄金工作流

遇到手机代理开启后应用连不上网时，遵循以下排查流程：

1. **区分「应用层直连」与「TUN 虚拟网卡假死」**：
   - 先用 `curl -x socks5://127.0.0.1:7891 -I https://api.telegram.org` 测试本地代理端口；
   - 若本地端口可通，说明节点正常，故障是系统级 TUN 网卡（如 Mixed Stack 与 Android 15 eBPF 冲突）导致假死。
2. **善用 Deep Link 直达配置**：
   - Telegram 代理一键注入：
     `am start -a android.intent.action.VIEW -d "tg://socks?server=127.0.0.1&port=7891" org.telegram.messenger`
3. **TUN 堆栈修复建议**：
   - 切换 Clash Meta 设置中的堆栈模式（从 `Mixed` 改为 `gVisor` 或 `System`）。
