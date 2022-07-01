using QuanLyQuanCafe.DTO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLyQuanCafe.DAO
{
    public class TableDAO
    {
        private static TableDAO instance;

        public void SwitchTable(int id1, int id2)
        {
            DataProvider.Instance.ExecuteQuery("dbo.USP_SwitchTable @idTable1 , @idTable2",new object []{id1, id2 });
        }
        public static TableDAO Instance 
        {
            get { if (instance == null) instance = new TableDAO(); return TableDAO.instance; }
            private set { TableDAO.instance = value; }
        }
        private TableDAO() { }

        public static int TableWidth = 130;
        public static int TableHeigth = 130;
        public List<Table> LoadTableList()
        {
            List<Table> tableList = new List<Table>();
            DataTable data = DataProvider.Instance.ExecuteQuery("USP_GetTableList");
            foreach (DataRow item in data.Rows)
            {
                Table table = new Table(item);
                tableList.Add(table);   
            }
            return tableList;
        }
        public List<Table> GetListTable()
        {
            List<Table> list = new List<Table>();
            string query = "select * from TableFood";
            DataTable data = DataProvider.Instance.ExecuteQuery(query);

            foreach (DataRow item in data.Rows)
            {
                Table table = new Table(item);
                list.Add(table);
            }
            return list;
        }
        public bool InsertTable(string name, string status)
        {
            string query = string.Format("INSERT dbo.TableFood ( name, status )VALUES  ( N'{0}', {1})", name, status);
            int result = DataProvider.Instance.ExecuteNonQuery(query);

            return result > 0;
        }
        public bool UpdateTable(int idTable, string name)
        {
            string query = string.Format("UPDATE dbo.TableFood SET name = N'{1}' WHERE id = N'{0}'", name, idTable);
            int result = DataProvider.Instance.ExecuteNonQuery(query);

            return result > 0;
        }
        public bool DeleteTable(int idTable)
        {
            BillInfoDAO.Instance.DeleteBillInfoByFoodID(idTable);

            string query = string.Format("Delete TableFood where id = {0}", idTable);
            int result = DataProvider.Instance.ExecuteNonQuery(query);

            return result > 0;
        }
    }
}
