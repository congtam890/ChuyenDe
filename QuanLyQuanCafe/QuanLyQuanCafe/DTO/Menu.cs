using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLyQuanCafe.DTO
{
     class Menu
    {
        public Menu(string foodName,int count, float price, float totalPrice = 0)
        {
            this.FoodName = foodName;
            this.Count = count;
            this.Price = price;
            this.toatalPrice = totalPrice;
        }
        private string foodName;

        public string FoodName { get => foodName; set => foodName = value; }
        public float Price { get => price; set => price = value; }
        public int Count { get => count; set => count = value; }
        public float ToatalPrice { get => toatalPrice; set => toatalPrice = value; }

        private float price;

        private int count;

        private float toatalPrice;
    }
    
}
