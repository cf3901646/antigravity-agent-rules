import os
import shutil
import glob

MASTER_PROFILE = r"C:\Users\Administrator\.gemini\browser_profiles\master_authenticated_profile"
PARTITIONS_DIR = r"C:\Users\Administrator\AppData\Roaming\Antigravity\Partitions"

def sync_to_partitions():
    if not os.path.exists(MASTER_PROFILE):
        print("Master profile not found!")
        return

    # Find all partitions in Antigravity
    if os.path.exists(PARTITIONS_DIR):
        for p_name in os.listdir(PARTITIONS_DIR):
            target_p = os.path.join(PARTITIONS_DIR, p_name)
            if os.path.isdir(target_p):
                # Copy Network/Cookies and Local Storage
                src_net = os.path.join(MASTER_PROFILE, "Network")
                dst_net = os.path.join(target_p, "Network")
                src_ls = os.path.join(MASTER_PROFILE, "Local Storage")
                dst_ls = os.path.join(target_p, "Local Storage")

                try:
                    if os.path.exists(src_net):
                        os.makedirs(dst_net, exist_ok=True)
                        for f in ["Cookies", "Cookies-journal", "Network Persistent State"]:
                            sf = os.path.join(src_net, f)
                            df = os.path.join(dst_net, f)
                            if os.path.exists(sf):
                                shutil.copy2(sf, df)
                    if os.path.exists(src_ls):
                        shutil.copytree(src_ls, dst_ls, dirs_exist_ok=True)
                    print(f"Synced master cookies & storage to partition: {p_name}")
                except Exception as e:
                    print(f"Error syncing to {p_name}:", e)

if __name__ == "__main__":
    sync_to_partitions()
