﻿Функция ПолучитьТЗИсполнителейЗадачи(ДопПараметры) Экспорт 
	
	пПользовать = ДопПараметры.Пользователь;
	пРольАдресации = ДопПараметры.РольАдресации;
	пПодразделениеАдресации = ДопПараметры.ПодразделениеАдресации;	
	
	Если ЗначениеЗаполнено(пПользовать) Тогда
		ТЗИсполнителиЗадачи = РегистрыСведений.бпсСвойстваЗадач.СоздатьНаборЗаписей().ВыгрузитьКолонки("Пользователь,РольАдресации,ПодразделениеАдресации");
		Если ТЗИсполнителиЗадачи.Найти(пПользовать,"Пользователь") = Неопределено Тогда
			СтрокаТЗИсполнителиЗадачи = ТЗИсполнителиЗадачи.Добавить();
			СтрокаТЗИсполнителиЗадачи.Пользователь = пПользовать;
		Конецесли;
		Возврат ТЗИсполнителиЗадачи;
	Конецесли;	
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	бпсРегистрАдресации.Пользователь,
	|	бпсРегистрАдресации.РольАдресации,
	|	бпсРегистрАдресации.ПодразделениеАдресации
	|ИЗ
	|	РегистрСведений.бпсРегистрАдресации КАК бпсРегистрАдресации
	|ГДЕ
	|	ВЫБОР
	|			КОГДА &ИспользоватьОтборПоПользователю
	|				ТОГДА бпсРегистрАдресации.Пользователь = &Пользователь
	|			ИНАЧЕ ИСТИНА
	|		КОНЕЦ
	|	И ВЫБОР
	|			КОГДА &ИспользоватьОтборПоРолиАдресации
	|				ТОГДА бпсРегистрАдресации.РольАдресации = &РольАдресации
	|			ИНАЧЕ ИСТИНА
	|		КОНЕЦ
	|	И ВЫБОР
	|			КОГДА &ИспользоватьОтборПоПодразделению
	|				ТОГДА бпсРегистрАдресации.ПодразделениеАдресации = &ПодразделениеАдресации
	|			ИНАЧЕ ИСТИНА
	|		КОНЕЦ";
	
	Запрос.УстановитьПараметр("ИспользоватьОтборПоПодразделению", ЗначениеЗаполнено(пПодразделениеАдресации));
	Запрос.УстановитьПараметр("ИспользоватьОтборПоПользователю", ЗначениеЗаполнено(пПользовать));
	Запрос.УстановитьПараметр("ИспользоватьОтборПоРолиАдресации", ЗначениеЗаполнено(пРольАдресации));
	Запрос.УстановитьПараметр("ПодразделениеАдресации", пПодразделениеАдресации);
	Запрос.УстановитьПараметр("Пользователь", пПользовать);
	Запрос.УстановитьПараметр("РольАдресации", пРольАдресации);
	
	ТЗИсполнителиЗадачи = Запрос.Выполнить().Выгрузить();
	
	Возврат ТЗИсполнителиЗадачи;		
КонецФункции //ПолучитьИсполнителейЗадачи()
