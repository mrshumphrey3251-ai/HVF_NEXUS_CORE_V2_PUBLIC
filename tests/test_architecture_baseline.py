import unittest
import os

class TestArchitecture(unittest.TestCase):
    def test_core_files_exist(self):
        """Verify that mission-critical Python engines exist in the root."""
        root_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
        critical_files = [
            "HVF_Executive_Command.py",
            "Aegis_Compliance_Oracle.py",
            "Sovereign_Hash_Router.py"
        ]
        for file in critical_files:
            filepath = os.path.join(root_dir, file)
            self.assertTrue(os.path.exists(filepath), f"CRITICAL FAILURE: {file} is missing from the ecosystem.")

if __name__ == '__main__':
    unittest.main()
