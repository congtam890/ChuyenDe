namespace QuanLyQuanCafe
{
    partial class fLogin
    {
        /// <summary>
        ///  Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        ///  Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        ///  Required method for Designer support - do not modify
        ///  the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.panel1 = new System.Windows.Forms.Panel();
            this.buttonExit = new System.Windows.Forms.Button();
            this.btnLogin = new System.Windows.Forms.Button();
            this.panel3 = new System.Windows.Forms.Panel();
            this.tbPassword = new System.Windows.Forms.TextBox();
            this.text = new System.Windows.Forms.Label();
            this.panel2 = new System.Windows.Forms.Panel();
            this.tbLogin = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.panel1.SuspendLayout();
            this.panel3.SuspendLayout();
            this.panel2.SuspendLayout();
            this.SuspendLayout();
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.buttonExit);
            this.panel1.Controls.Add(this.btnLogin);
            this.panel1.Controls.Add(this.panel3);
            this.panel1.Controls.Add(this.panel2);
            this.panel1.Location = new System.Drawing.Point(12, 12);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(531, 149);
            this.panel1.TabIndex = 0;
            // 
            // buttonExit
            // 
            this.buttonExit.Location = new System.Drawing.Point(393, 119);
            this.buttonExit.Name = "buttonExit";
            this.buttonExit.Size = new System.Drawing.Size(75, 23);
            this.buttonExit.TabIndex = 4;
            this.buttonExit.Text = "Thoát";
            this.buttonExit.UseVisualStyleBackColor = true;
            this.buttonExit.Click += new System.EventHandler(this.button2_Click);
            // 
            // btnLogin
            // 
            this.btnLogin.Location = new System.Drawing.Point(288, 119);
            this.btnLogin.Name = "btnLogin";
            this.btnLogin.Size = new System.Drawing.Size(75, 23);
            this.btnLogin.TabIndex = 3;
            this.btnLogin.Text = "Đăng Nhập";
            this.btnLogin.UseVisualStyleBackColor = true;
            this.btnLogin.Click += new System.EventHandler(this.button1_Click);
            // 
            // panel3
            // 
            this.panel3.Controls.Add(this.tbPassword);
            this.panel3.Controls.Add(this.text);
            this.panel3.Location = new System.Drawing.Point(6, 56);
            this.panel3.Name = "panel3";
            this.panel3.Size = new System.Drawing.Size(536, 57);
            this.panel3.TabIndex = 1;
            this.panel3.Paint += new System.Windows.Forms.PaintEventHandler(this.panel3_Paint);
            // 
            // tbPassword
            // 
            this.tbPassword.Location = new System.Drawing.Point(194, 7);
            this.tbPassword.Name = "tbPassword";
            this.tbPassword.Size = new System.Drawing.Size(327, 23);
            this.tbPassword.TabIndex = 2;
            this.tbPassword.UseSystemPasswordChar = true;
            this.tbPassword.TextChanged += new System.EventHandler(this.textBox2_TextChanged);
            // 
            // text
            // 
            this.text.AutoSize = true;
            this.text.Font = new System.Drawing.Font("Arial", 14.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.text.Location = new System.Drawing.Point(68, 7);
            this.text.Name = "text";
            this.text.Size = new System.Drawing.Size(110, 22);
            this.text.TabIndex = 0;
            this.text.Text = "Password:";
            this.text.Click += new System.EventHandler(this.label2_Click);
            // 
            // panel2
            // 
            this.panel2.Controls.Add(this.tbLogin);
            this.panel2.Controls.Add(this.label1);
            this.panel2.Location = new System.Drawing.Point(6, 3);
            this.panel2.Name = "panel2";
            this.panel2.Size = new System.Drawing.Size(536, 54);
            this.panel2.TabIndex = 0;
            // 
            // tbLogin
            // 
            this.tbLogin.Location = new System.Drawing.Point(194, 24);
            this.tbLogin.Name = "tbLogin";
            this.tbLogin.Size = new System.Drawing.Size(327, 23);
            this.tbLogin.TabIndex = 1;
            this.tbLogin.TextChanged += new System.EventHandler(this.textboxLogin_TextChanged);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Arial", 14.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.label1.Location = new System.Drawing.Point(18, 24);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(160, 22);
            this.label1.TabIndex = 0;
            this.label1.Text = "Tên Đăng Nhập:";
            this.label1.Click += new System.EventHandler(this.label1_Click);
            // 
            // fLogin
            // 
            this.AcceptButton = this.btnLogin;
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.CancelButton = this.buttonExit;
            this.ClientSize = new System.Drawing.Size(555, 173);
            this.Controls.Add(this.panel1);
            this.Name = "fLogin";
            this.Text = "Đăng Nhập";
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.Login_FormClosing);
            this.panel1.ResumeLayout(false);
            this.panel3.ResumeLayout(false);
            this.panel3.PerformLayout();
            this.panel2.ResumeLayout(false);
            this.panel2.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private Panel panel1;
        private Panel panel2;
        private Label label1;
        private TextBox tbLogin;
        private Panel panel3;
        private TextBox tbPassword;
        private Label text;
        private Button btnLogin;
        private Button buttonExit;
    }
}