using QuanLyQuanCafe.DAO;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QuanLyQuanCafe
{
    public partial class fAdmin : Form
    {
        public fAdmin()
        {
           InitializeComponent();
            LoadBillByDate(dtptFromDate.Value, dtptToDate.Value);
        }
        #region methods
        void LoadDateTimePickerBill()
        {
            DateTime Today = DateTime.Now;
            dtptFromDate.Value = new DateTime(Today.Year, Today.Month, 1);
            dtptToDate.Value = dtptFromDate.Value.AddMonths(1).AddDays(-1);
        }
        void LoadBillByDate(DateTime checkIn, DateTime checkOut)
        {
            dtgvBill.DataSource = BillDAO.Instance.GetBillListByDate(checkIn , checkOut);
        }
        #endregion
        #region Event
        private void panel1_Paint(object sender, PaintEventArgs e)
        {

        }

        private void dateTimePicker2_ValueChanged(object sender, EventArgs e)
        {

        }

        private void tpBill_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {

        }

        private void label4_Click(object sender, EventArgs e)
        {

        }

        private void label9_Click(object sender, EventArgs e)
        {

        }

        private void fAdmin_Load(object sender, EventArgs e)
        {

        }

        private void btnViewBill_Click(object sender, EventArgs e)
        {
            LoadBillByDate(dtptFromDate.Value, dtptToDate.Value );
        }
        #endregion

        private void dtgvBill_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
    }
}
