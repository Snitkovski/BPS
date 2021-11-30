﻿
&НаСервере
Функция ОпределитьОтборНаСервере(пНастройкиКомпоновщика = Неопределено) Экспорт
	МакетСКД = Справочники.бпсУсловия.ПолучитьМакетСКДДляТипаОбъектаБД(Объект.Владелец);
	
	АдресВременногоХранилищаМакетаСКД = ПоместитьВоВременноеХранилище(МакетСКД, Новый УникальныйИдентификатор());
	
	ИсточникНастроек = Новый ИсточникДоступныхНастроекКомпоновкиДанных(АдресВременногоХранилищаМакетаСКД);
	КомпоновщикНастроекКомпоновкиДанных.Инициализировать(ИсточникНастроек);
	
	Если пНастройкиКомпоновщика = Неопределено Тогда
		КомпоновщикНастроекКомпоновкиДанных.ЗагрузитьНастройки(МакетСКД.НастройкиПоУмолчанию);
	Иначе
		КомпоновщикНастроекКомпоновкиДанных.ЗагрузитьНастройки(пНастройкиКомпоновщика);
	Конецесли;
	//ЗначениеВРеквизитФормы(КомпоновщикНастроекКомпоновкиДанных,"КомпоновщикНастроекКомпоновкиДанных");
	//ЗначениеВРеквизитФормы(СправочникОбъект,"Объект");
КонецФункции

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если ЗначениеЗаполнено(Объект.Владелец) Тогда
		СправочникОбъект = РеквизитФормыВЗначение("Объект");
		пНастройкиКомпоновщика = СправочникОбъект.НастройкиКомпоновщикаХранилище.Получить();
		ОпределитьОтборНаСервере(пНастройкиКомпоновщика);
	Конецесли;
	УстановитьВидимостьДоступность();
КонецПроцедуры


&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)
	Объект.АдресВременногоХранилища = ПоместитьВоВременноеХранилище(КомпоновщикНастроекКомпоновкиДанных.Настройки,Новый УникальныйИдентификатор());	
КонецПроцедуры

&НаСервере
Процедура УстановитьВидимостьДоступность() Экспорт
	Элементы.ГруппаСтраницаОтборы.Видимость = Ложь;
	//Элементы.ГруппаСтраницаТекстЗапроса.Видимость = Ложь;
	Элементы.ГруппаТекстПроизвольногоУсловия.Видимость = Ложь;
	
	Если Объект.ПроизвольноеУсловие Тогда
		Элементы.ГруппаТекстПроизвольногоУсловия.Видимость = Истина;
	Иначе
		Элементы.ГруппаСтраницаОтборы.Видимость = Истина;
		//Элементы.ГруппаСтраницаТекстЗапроса.Видимость = Истина;
	Конецесли;
КонецПроцедуры //УстановитьВидимостьДоступность()

&НаКлиенте
Процедура КомпоновщикНастроекКомпоновкиДанныхНастройкиОтборПриОкончанииРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования)
	СформироватьНаименование();
КонецПроцедуры


&НаКлиенте
Процедура ПроизвольноеУсловиеПриИзменении(Элемент)
	УстановитьВидимостьДоступность();
КонецПроцедуры


&НаКлиенте
Процедура КомпоновщикНастроекКомпоновкиДанныхНастройкиОтборПриИзменении(Элемент)
	СформироватьНаименование();
КонецПроцедуры

&НаКлиенте
Процедура СформироватьНаименование()
	Объект.Наименование = "" + КомпоновщикНастроекКомпоновкиДанных.Настройки.Отбор;
КонецПроцедуры //СформироватьНаименование()


&НаКлиенте
Процедура ВладелецПриИзменении(Элемент)
	ОпределитьОтборНаСервере();
КонецПроцедуры

