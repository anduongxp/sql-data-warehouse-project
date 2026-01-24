/* ========================================================= Tạo Cơ sở dữ liệu (Database) và các Schema =========================================================

Mục đích của Script: Script này tạo ra một cơ sở dữ liệu mới có tên là 'DataWarehouse' sau khi kiểm tra xem nó đã tồn tại hay chưa. 
Nếu cơ sở dữ liệu đã tồn tại, nó sẽ bị xóa bỏ (dropped) và được tạo lại mới. 
Ngoài ra, script này cũng thiết lập ba schema bên trong cơ sở dữ liệu gồm: 'bronze', 'silver', và 'gold'.

CẢNH BÁO: 
Việc chạy script này sẽ xóa bỏ (drop) toàn bộ cơ sở dữ liệu 'DataWarehouse' nếu nó đang tồn tại. 
Tất cả dữ liệu bên trong cơ sở dữ liệu sẽ bị xóa vĩnh viễn. Hãy thực hiện thận trọng và đảm bảo bạn đã sao lưu (backup) đầy đủ trước khi chạy script này. 
*/
USE master;
GO

-- Drop and recreate the 'DataWarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
END;
GO

-- Create the 'DataWarehouse' database
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

-- Create Schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO

