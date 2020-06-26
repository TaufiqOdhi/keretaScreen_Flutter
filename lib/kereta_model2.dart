class Kereta {
	String status;
	DataKereta data;

	Kereta({this.status, this.data});

	Kereta.fromJson(Map<String, dynamic> json) {
		status = json['status'];
		data = json['data'] != null ? new DataKereta.fromJson(json['data']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['status'] = this.status;
		if (this.data != null) {
      data['data'] = this.data.toJson();
    }
		return data;
	}
}

class DataKereta {
	int errorCode;
	String errorMsg;
	String org;
	String des;
	String trip;
	String tglDep;
	int admin;
	int totalAmount;
	Seat seat;

	DataKereta({this.errorCode, this.errorMsg, this.org, this.des, this.trip, this.tglDep, this.admin, this.totalAmount, this.seat});

	DataKereta.fromJson(Map<String, dynamic> json) {
		errorCode = json['error_code'];
		errorMsg = json['error_msg'];
		org = json['org'];
		des = json['des'];
		trip = json['trip'];
		tglDep = json['tgl_dep'];
		admin = json['admin'];
		totalAmount = json['totalAmount'];
		seat = json['seat'] != null ? new Seat.fromJson(json['seat']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['error_code'] = this.errorCode;
		data['error_msg'] = this.errorMsg;
		data['org'] = this.org;
		data['des'] = this.des;
		data['trip'] = this.trip;
		data['tgl_dep'] = this.tglDep;
		data['admin'] = this.admin;
		data['totalAmount'] = this.totalAmount;
		if (this.seat != null) {
      data['seat'] = this.seat.toJson();
    }
		return data;
	}
}

class Seat {
	Departure departure;

	Seat({this.departure});

	Seat.fromJson(Map<String, dynamic> json) {
		departure = json['departure'] != null ? new Departure.fromJson(json['departure']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.departure != null) {
      data['departure'] = this.departure.toJson();
    }
		return data;
	}
}

class Departure {
	int trainNo;
	String subClass;
	List<SeatMap> seatMap;

	Departure({this.trainNo, this.subClass, this.seatMap});

	Departure.fromJson(Map<String, dynamic> json) {
		trainNo = json['TrainNo'];
		subClass = json['SubClass'];
		if (json['seat_map'] != null) {
			seatMap = new List<SeatMap>();
			json['seat_map'].forEach((v) { seatMap.add(new SeatMap.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['TrainNo'] = this.trainNo;
		data['SubClass'] = this.subClass;
		if (this.seatMap != null) {
      data['seat_map'] = this.seatMap.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class SeatMap {
	String kodeWagon;
	String noWagon;
	int jmlRow;
	int jmlCol;
	List<ListAvl> avl;

	SeatMap({this.kodeWagon, this.noWagon, this.jmlRow, this.jmlCol, this.avl});

	SeatMap.fromJson(Map<String, dynamic> json) {
		kodeWagon = json['kode_wagon'];
		noWagon = json['no_wagon'];
		jmlRow = json['jml_row'];
		jmlCol = json['jml_col'];
		if (json['avl'] != null) {
			avl = new List<ListAvl>();
			json['avl'].forEach((v) { avl.add(new ListAvl.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['kode_wagon'] = this.kodeWagon;
		data['no_wagon'] = this.noWagon;
		data['jml_row'] = this.jmlRow;
		data['jml_col'] = this.jmlCol;
		if (this.avl != null) {
      data['avl'] = this.avl.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class ListAvl {
  List<dynamic> dataAvl;

	ListAvl({this.dataAvl});

	ListAvl.fromJson(List<dynamic> json) {
    dataAvl = json;
	}

	List<dynamic> toJson() {
		final List<dynamic> data = this.dataAvl;
		return data;
	}
}
