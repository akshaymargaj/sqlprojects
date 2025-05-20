-------------- Tables creation script for the project --------------

-------------- Dim Airline --------------

CREATE TABLE [dbo].[dim_airline](
	[IATA] [nvarchar](50) PRIMARY KEY,
	[ICAO] [nvarchar](50),
	[Airline_Name] [nvarchar](50),
	[Country] [nvarchar](50),
	[Headquarters] [nvarchar](50),
	[Website_URL] [nvarchar](50),
	[Airplane_Capacity] [smallint],
	[Airplane_Weight] [float],
	[Type] [nvarchar](50),
	[Status] [nvarchar](50) 
)

-------------- Dim Airport (Departure airports) --------------
	
CREATE TABLE [dbo].[dim_airports_uk](
	[IATA] [nvarchar](50) PRIMARY KEY,
	[ICAO] [nvarchar](50),
	[Airport_Name] [nvarchar](50),
	[City_Served] [nvarchar](50),
	[Region] [nvarchar](50),
	[Location] [nvarchar](50),
	[Runways_Count] [tinyint],
	[Terminal_Count] [tinyint],
	[Owned_By] [nvarchar](50),
	[Operated_By] [nvarchar](50),
	[Website_URL] [nvarchar](50),
	[Date_Opened] [smallint]
)

-------------- Dim International/Arrival Airports --------------

CREATE TABLE [dbo].[dim_International_airports](
	[IATA] [nvarchar](50) PRIMARY KEY,
	[ICAO] [nvarchar](50),
	[Airport_Name] [nvarchar](100),
	[City_Served] [nvarchar](50),
	[Region] [nvarchar](50),
	[Location] [nvarchar](50),
	[Time_Zone] [nvarchar](50),
	[Runways_Count] [tinyint],
	[Terminal_Count] [tinyint],
	[International_Status] [nvarchar](100),
	[Owned_By] [nvarchar](100),
	[Operated_By] [nvarchar](100),
	[Website_URL] [nvarchar](50),
	[Date_Opened] [smallint]
	)

-------------- Dim Date --------------

CREATE TABLE [dbo].[dim_date](
	[Date] [date] PRIMARY KEY,
	[Year] [smallint],
	[Month_Number] [tinyint],
	[Month_Name] [nvarchar](50),
	[Month_Short] [nvarchar](50),
	[Quarter] [money],
	[DayofMonth] [tinyint],
	[DayofWeek] [tinyint],
	[Day_Name] [nvarchar](50),
	[Day_Short] [nvarchar](50),
	[IsWeekend] [bit]
)

-------------- Dim Delay Category --------------

CREATE TABLE [dbo].[dim_delaycategory](
	[DELAY_ID] [nvarchar](50) PRIMARY KEY,
	[DELAY_CODE] [nvarchar](50),
	[DELAY_NAME] [nvarchar](50),
	[UNIT] [nvarchar](50),
	[SOURCE_SYSTEM] [nvarchar](50),
	[DELAY_SEVERITY] [nvarchar](50),
	[IS_CANCELLATION] [bit]
)

-------------- Dim Flight Type --------------
	
CREATE TABLE [dbo].[dim_flight_type](
	[Code] [nvarchar](50) PRIMARY KEY,
	[Flight_Type] [nvarchar](50),
	[Description] [nvarchar](100),
	[Operation_Mode] [nvarchar](100),
	[Typical_Use_Case] [nvarchar](50),
	[Regulatory_Requirements] [nvarchar](50),
	[Booking_Method] [nvarchar](50),
	[Status] [nvarchar](50)
)

-------------- Fact punctuality stats --------------
	
CREATE TABLE [dbo].[Punchuality_Stats_Fact_final](
	[FP_ID] [int] PRIMARY KEY,
	[REPORTING_PERIOD] [date],
	[DEPARTURE_ID] [nvarchar](50),
	[ARRIVAL_COUNTRY_ID] [nvarchar](50),
	[ARRIVAL_ID] [nvarchar](50),
	[AIRLINE_ID] [nvarchar](50),
	[ROUTE_ID] [nvarchar](50),
	[FLIGHT_TYPE_ID] [nvarchar](50),
	[FLIGHTS_MATCHED] [int],
	[FLIGHTS_CANCELLED] [int],
	[AVERAGE_DELAY] [float],
	[PY_MONTH_FLIGHTS_MATCHED] [int],
	[PY_MONTH_AVERAGE_DELAY] [float],
	[CATEGORY] [nvarchar](50),
	[value] [float],
CONSTRAINT fk_Punchuality_Stats_Fact_final_dim_date FOREIGN KEY (REPORTING_PERIOD) REFERENCES dim_date(Date)
	CONSTRAINT fk_Punchuality_Stats_Fact_final _dim_airports_uk FOREIGN KEY (DEPARTURE_ID) REFERENCES dim_airports_uk(IATA)
	CONSTRAINT fk_Punchuality_Stats_Fact_final_dim_International_airports FOREIGN KEY ([DEPARTURE_ID]) REFERENCES dim_International_airports (IATA),
	CONSTRAINT fk_Punchuality_Stats_Fact_final_dim_flight_type FOREIGN KEY ([FLIGHT_TYPE_ID]) REFERENCES dim_flight_type(Code)
	CONSTRAINT fk_ Punchuality_Stats_Fact_final_ dim_airline FOREIGN KEY ([AIRLINE_ID]) REFERENCES dim_airline(IATA)
) 
