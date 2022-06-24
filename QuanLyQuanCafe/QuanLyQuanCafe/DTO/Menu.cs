using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLyQuanCafe.DTO
{
     public class Menu
    {
        public Menu(string foodName,int count, float price, float totalPrice = 0)
        {
            this.FoodName = foodName;
            this.Count = count;
            this.Price = price;
            this.totalPrice = totalPrice;
        }
        public Menu(DataRow row)
        {
            this.FoodName = row["name"].ToString();
            this.Count = (int)row["count"];
            this.Price = (float)Convert.ToDouble(row["price"].ToString());
            this.totalPrice = (float)Convert.ToDouble(row["totalPrice"].ToString());
        }
        private string foodName;

        private float price;

        private int count;

        private float totalPrice;
        public string FoodName { get { return foodName; } set { foodName = value; } }
        public float Price { get { return price; } set { price = value; } }
        public int Count { get { return count; } set { count = value; } }
        public float TotalPrice { get { return totalPrice; } set { totalPrice = value; } }

    }
    
}
