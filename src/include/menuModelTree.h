#ifndef MENUMODELTREE_H
#define MENUMODELTREE_H

#include <QAbstractItemModel>
#include <QQmlEngine>
#include <QMutexLocker>
/**
 * @brief The MenuModelTree class реализующие древовидную структуру меню.
 *
 * Пункты меню живут статически в контейнере.
 * Добавление/удаление == Видимость/Невидимость - реализовано, как вставка/удаление из структуры дерева
 * меню, а сами пункты "живут" в контейнере.
 */
class MenuModelTree : public QAbstractItemModel
{
    Q_OBJECT
public:
    explicit MenuModelTree(QObject *parent = nullptr);
    ~MenuModelTree();

    Q_PROPERTY(QStringList popupList    MEMBER popupList_    NOTIFY popupListChanged)    // model for popup with List

    enum MENU_ID
    {
        SALES_ID = 1,
        ORDERS_ID,
        KASSA_ID,
        TAXS_CLOUD_ID,
            SHIFT_ID,
                SHIFT_ID_OPEN,
                SHIFT_ID_CLOSE,
                SHIFT_ID_X_REPORT,
                SHIFT_ID_RESERVE,
                SHIFT_ID_INSERTION,
                SHIFT_ID_INS_RES,
                SHIFT_ID_COPY_FISCAL_DOC,
                SHIFT_ID_COPY_FISCAL_DOC_LAST,
                SHIFT_ID_COPY_FISCAL_DOC_NUMBER,
                SHIFT_ID_CANCEL_DOC,
                SHIFT_ID_PRINT_CTRL_TAPE,
                SHIFT_ID_PRINT_MEM_UNIT,
                SHIFT_ID_KL_DOC_COPY,
                SHIFT_ID_CARD_BALANCE,
            DOCS_ID,
                DOCS_ID_CUR_REP,
                DOCS_ID_DOC_FN,
                DOCS_ID_DOC_FN_ONE,
                DOCS_ID_DOC_FN_ALL,
                DOCS_ID_DOC_FN_ALL_TO_FLASH,
                DOCS_ID_DOC_FN_TO_CRPT,
                DOCS_ID_DOC_FISCAL_RESULT,
                DOCS_ID_DOC_FISCAL_RESULT_ONE,
                DOCS_ID_DOC_FISCAL_RESULT_ALL,
                DOCS_ID_RECEIPT_COR,
            ADD_OPERATIONS_ID,
                CONSUMPTION_ID,
                REVERT_ID_REV,
                    REVERT_ID_REV_COM,
                    REVERT_ID_REV_CON,
            SYSTEM_ID,
                SYSTEM_ID_CH_USER,
                SYSTEM_ID_POWEROFF,
                SYSTEM_ID_REBOOT,
                SYSTEM_ID_LOG,
                    SYSTEM_ID_LOG_LEVEL,
                        SYSTEM_ID_LOG_LEVEL_ERROR,
                        SYSTEM_ID_LOG_LEVEL_WARN,
                        SYSTEM_ID_LOG_LEVEL_INFO,
                        SYSTEM_ID_LOG_LEVEL_DEBUG,
                    SYSTEM_ID_SAVE_LOG,
                    SYSTEM_ID_SEND_LOG,
                SYSTEM_ID_VERSION,
                SYSTEM_ID_VERSION_UPDATE,
                SYSTEM_ID_VERSION_REVERT,
                SYSTEM_ID_SAVE_LIB,
                SYSTEM_ID_RESET,
                SYSTEM_ID_USERS,
                    SYSTEM_ID_USERS_INSERT,
                    SYSTEM_ID_USERS_EDIT,
                    SYSTEM_ID_USERS_DELETE,
                SYSTEM_ID_COUNTERS_EDIT,
                    SYSTEM_ID_CASH_IN_FINAL,
                    SYSTEM_ID_ADVENT_TOTAL_ABS,
                    SYSTEM_ID_CONSUMPTION_TOTAL_ABS,
                    SYSTEM_ID_ADVENT_RETURN_TOTAL_ABS,
                    SYSTEM_ID_CONSUMPTION_RETURN_TOTAL_ABS,
                SYSTEM_ID_DELETE_GOODS,
                SYSTEM_ID_HOTKEYS,
                    SYSTEM_ID_HOTKEYS_DELETE,
                SYSTEM_ID_DIAGNOSTIC,
            SETTINGS_ID,
                SETTINGS_ID_OFD,
                    SETTINGS_ID_OFD_REG_KKT,
                    SETTINGS_ID_OFD_EDIT_DATA,
                    SETTINGS_ID_OFD_CH_OFD,
                    SETTINGS_ID_OFD_TUNE_OFD,
                    SETTINGS_ID_OFD_REPLACE_FS,
                    SETTINGS_ID_OFD_FS_DAMAGED,
                    SETTINGS_ID_OFD_DEREG_KKT,
                    SETTINGS_ID_OFD_OFFLINE,
                    SETTINGS_ID_OFD_CANCEL,
                    SETTINGS_ID_OFD_KKT_MODE,
                    SETTINGS_ID_OFD_REG_KKT_KPP,
                SETTINGS_ID_NET,
                    SETTINGS_ID_NET_ETHERNET,
                        SETTINGS_ID_NET_ETHERNET_STATE,
                        SETTINGS_ID_NET_ETHERNET_SET,
                    SETTINGS_ID_NET_WIFI,
                        SETTINGS_ID_NET_WIFI_STATE,
                        SETTINGS_ID_NET_WIFI_SET,
                    SETTINGS_ID_NET_2G,
                        SETTINGS_ID_NET_2G_ON,
                        SETTINGS_ID_NET_2G_OFF,
                SETTINGS_ID_DATE_ZONE,
                    SETTINGS_ID_DATE_TIME,
                    SETTINGS_ID_TIME_ZONE,
                SETTINGS_EQUIPMENT,
                    SETTINGS_EQUIPMENT_ID_SCALES,
                        SETTINGS_EQUIPMENT_ID_SCALES_USE_TARE,
                        SETTINGS_EQUIPMENT_ID_SCALES_MY_TARE,
                            SETTINGS_EQUIPMENT_ID_SCALES_MY_TARE_ADD,
                            SETTINGS_EQUIPMENT_ID_SCALES_MY_TARE_ALL_TARES,
                            SETTINGS_EQUIPMENT_ID_SCALES_MY_TARE_DEFAULT_TARE,
                        SETTINGS_EQUIPMENT_ID_SCALES_INFO,
                    SETTINGS_EQUIPMENT_ID_BANK_TERM,
                        SETTINGS_EQUIPMENT_ID_BANK_TERM_STATE,
                        SETTINGS_EQUIPMENT_ID_BANK_TERM_TYPE,
                        SETTINGS_EQUIPMENT_ID_BANK_TERM_OPS,
                            SETTINGS_EQUIPMENT_ID_BANK_TERM_OPS_KEYS,
                            SETTINGS_EQUIPMENT_ID_BANK_TERM_OPS_KEYS_DEF,
                            SETTINGS_EQUIPMENT_ID_BANK_TERM_OPS_KEYS_MASTER,
                            SETTINGS_EQUIPMENT_ID_BANK_TERM_OPS_KEYS_WORK,
                            SETTINGS_EQUIPMENT_ID_BANK_TERM_OPS_PARAM,
                            SETTINGS_EQUIPMENT_ID_BANK_TERM_OPS_CONN,
                            SETTINGS_EQUIPMENT_ID_BANK_TERM_OPS_INFO,
                            SETTINGS_EQUIPMENT_ID_BANK_TERM_OPS_EMV,
                            SETTINGS_EQUIPMENT_ID_BANK_TERM_SKYPOS_CASHIER,
                                SETTINGS_EQUIPMENT_ID_BANK_TERM_SKYPOS_REVERSAL_LAST,
                                SETTINGS_EQUIPMENT_ID_BANK_TERM_RECON,
                                SETTINGS_EQUIPMENT_ID_BANK_TERM_SKYPOS_TEST_CON,
                                SETTINGS_EQUIPMENT_ID_BANK_TERM_SKYPOS_SHORT_REPORT,
                                SETTINGS_EQUIPMENT_ID_BANK_TERM_SKYPOS_FULL_REPORT,
                                SETTINGS_EQUIPMENT_ID_BANK_TERM_SKYPOS_TC_INFO,
                                SETTINGS_EQUIPMENT_ID_BANK_TERM_SKYPOS_TC_VALIDATE,
                                SETTINGS_EQUIPMENT_ID_BANK_TERM_SKYPOS_UPLOAD_LOGS,
                                SETTINGS_EQUIPMENT_ID_BANK_TERM_SKYPOS_REBOOT,
                            SETTINGS_EQUIPMENT_ID_BANK_TERM_SKYPOS_SET,
                                SETTINGS_EQUIPMENT_ID_BANK_TERM_SET_DATE_TIME,
                                SETTINGS_EQUIPMENT_ID_BANK_TERM_SKYPOS_SERVICE_MENU,
                                SETTINGS_EQUIPMENT_ID_BANK_TERM_SKYPOS_TMS,
                                SETTINGS_EQUIPMENT_ID_BANK_TERM_SKYPOS_ACTIVATION,
                    SETTINGS_EQUIPMENT_ID_BLUETOOTH,
                        SETTINGS_EQUIPMENT_ID_BLUETOOTH_ON,
                        SETTINGS_EQUIPMENT_ID_BLUETOOTH_OFF,
                        SETTINGS_EQUIPMENT_ID_BLUETOOTH_PAIR,
                SETTINGS_ID_DISCONT,
                SETTINGS_ID_TECH_REP,
                SETTINGS_ID_TAXS,
                SETTINGS_ID_CABINET,
                SETTINGS_ID_AGENTS,
                SETTINGS_ID_TRADE_RULES,
                    SETTINGS_ID_TRADE_RULES_DISCOUNTS,
                        SETTINGS_ID_TRADE_RULES_DISCOUNT_ADD,
                            SETTINGS_ID_TRADE_RULES_DISCOUNT_ADD_RUB,
                            SETTINGS_ID_TRADE_RULES_DISCOUNT_ADD_PERC,
                        SETTINGS_ID_TRADE_RULES_DISCOUNT_DEL,
                    SETTINGS_ID_TRADE_RULES_FREE_PRICE,
                    SETTINGS_ID_TRADE_RULES_TOBACCO_MRC,
                            SETTINGS_ID_TRADE_RULES_PAY_FUNCS,
                                SETTINGS_ID_TRADE_RULES_PAY_FUNCS_ACTIVE,
                                SETTINGS_ID_TRADE_RULES_PAY_FUNCS_EXPIRED,
                            SETTINGS_ID_TRADE_RULES_FREE_PRICE_NDS,
                            SETTINGS_ID_TRADE_RULES_FREE_PRICE_NDS_EDIT,
                                SETTINGS_ID_TRADE_RULES_FREE_PRICE_NDS_RB_1,
                                SETTINGS_ID_TRADE_RULES_FREE_PRICE_NDS_RB_2,
                                SETTINGS_ID_TRADE_RULES_FREE_PRICE_NDS_RB_3,
                                SETTINGS_ID_TRADE_RULES_FREE_PRICE_NDS_RB_4,
                                SETTINGS_ID_TRADE_RULES_FREE_PRICE_NDS_RB_5,
                                SETTINGS_ID_TRADE_RULES_FREE_PRICE_NDS_RB_6,
                            SETTINGS_ID_TRADE_RULES_FREE_PRICE_NDS_CHOOSE,
                        SETTINGS_ID_TRADE_RULES_FREE_PRICE_DEP,
                            SETTINGS_ID_TRADE_RULES_FREE_PRICE_DEP_EDIT,
                                SETTINGS_ID_TRADE_RULES_FREE_PRICE_DEP_1,
                                SETTINGS_ID_TRADE_RULES_FREE_PRICE_DEP_2,
                                SETTINGS_ID_TRADE_RULES_FREE_PRICE_DEP_3,
                                SETTINGS_ID_TRADE_RULES_FREE_PRICE_DEP_4,
                                SETTINGS_ID_TRADE_RULES_FREE_PRICE_DEP_5,
                                SETTINGS_ID_TRADE_RULES_FREE_PRICE_DEP_6,
                                SETTINGS_ID_TRADE_RULES_FREE_PRICE_DEP_7,
                                SETTINGS_ID_TRADE_RULES_FREE_PRICE_DEP_8,
                                SETTINGS_ID_TRADE_RULES_FREE_PRICE_DEP_9,
                                SETTINGS_ID_TRADE_RULES_FREE_PRICE_DEP_10,
                                SETTINGS_ID_TRADE_RULES_FREE_PRICE_DEP_11,
                                SETTINGS_ID_TRADE_RULES_FREE_PRICE_DEP_12,
                                SETTINGS_ID_TRADE_RULES_FREE_PRICE_DEP_13,
                                SETTINGS_ID_TRADE_RULES_FREE_PRICE_DEP_14,
                                SETTINGS_ID_TRADE_RULES_FREE_PRICE_DEP_15,
                                SETTINGS_ID_TRADE_RULES_FREE_PRICE_DEP_16,
                            SETTINGS_ID_TRADE_RULES_FREE_PRICE_DEP_CHOOSE,
                            SETTINGS_ID_TRADE_RULES_EGAIS,
                                SETTINGS_ID_TRADE_RULES_EGAIS_SALE_ALCOHOL,
                                SETTINGS_ID_TRADE_RULES_EGAIS_SET_UTM,
                                    SETTINGS_ID_TRADE_RULES_EGAIS_SET_UTM_IP,
                                    SETTINGS_ID_TRADE_RULES_EGAIS_SET_UTM_PORT,
                                    SETTINGS_ID_TRADE_RULES_EGAIS_SET_UTM_TIMEOUT,
                                    SETTINGS_ID_TRADE_RULES_EGAIS_SET_UTM_CHECK_CONNECTION,
                                    SETTINGS_ID_TRADE_RULES_EGAIS_SET_PRINT,
                                SETTINGS_ID_TRADE_RULES_EGAIS_SALE_CONTROL,
                                    SETTINGS_ID_TRADE_RULES_EGAIS_SALE_CONTROL_SET_CHECK_TIME,
                                    SETTINGS_ID_TRADE_RULES_EGAIS_SALE_CONTROL_SET_CHECK_TIME_HOURS,
                                SETTINGS_ID_TRADE_RULES_EGAIS_REQUEST_MRP_TABLES,
                    SETTINGS_ID_TRADE_RULES_AUTO_RESERVE,
                    SETTINGS_ID_TRADE_RULES_ENVD,
                    SETTINGS_ID_TRADE_RULES_INC_POS,
                    SETTINGS_ID_TRADE_RULES_FREE_PRICE_SALE,
                    SETTINGS_ID_TRADE_RULES_FREE_PRICE_SALE_MAX_SUM,
                    SETTINGS_ID_TRADE_RULES_CLOUD_LOAD,
                    SETTINGS_ID_SOUND_BUTTON,
                    SETTINGS_ID_DISCOUNTS,
                        SETTINGS_ID_DISCOUNTS_ADD,
                        SETTINGS_ID_DISCOUNTS_REMOVE,
        SETTINGS_ID_TRADE_RULES_ENTER_WEIGHT,
        SETTINGS_ID_TRADE_RULES_ENTER_WEIGHT_ON,
        SETTINGS_ID_TRADE_RULES_ENTER_WEIGHT_OFF,
        SETTINGS_ID_TRADE_RULES_PAY_TYPES,
            SETTINGS_ID_TRADE_RULES_PAY_TYPES_CREATE,
            SETTINGS_ID_TRADE_RULES_PAY_TYPES_EDIT,
            SETTINGS_ID_TRADE_RULES_PAY_TYPES_DELETE,
        SETTINGS_ID_REG_BSO,
                SETTINGS_ID_INTERNET_SHOP,
                SETTINGS_ID_INTERNET_AUTO_RECIEPT,
                    SETTINGS_AUTO_OPEN_SHIFT_EN,
                    SETTINGS_AUTO_OPEN_SHIFT_DIS,
        SETTINGS_ID_ROUTE_DATA,
            SETTINGS_ID_ROUTE_DATA_INSPECTOR_ID,
            SETTINGS_ID_ROUTE_DATA_DRIVER_ID,
            SETTINGS_ID_ROUTE_DATA_RUN_ID,
            SETTINGS_ID_ROUTE_DATA_TAIL_NUMBER,
            SETTINGS_ID_ROUTE_DATA_ROUTE_ID,
            SETTINGS_ID_ROUTE_DATA_START_ZONE,
            SETTINGS_ID_ROUTE_DATA_PLATE_NUMBER,
            SETTINGS_ID_ROUTE_DATA_VEHICLE_ID,
            SETTINGS_ID_ROUTE_DATA_VEHICLE_TYPE,
            SETTINGS_ID_ROUTE_DATA_OPERATOR_ID,
        SETTINGS_ID_BEER,
        SPEC_CLC_METHOD,
            SPEC_CLC_METHOD_ON_POS,
                DISCOUNT_POSITION,
                FULL_PREPAYMENT,
                PREPAYMENT,
                IMPREST,
                FULL_CREDIT,
                PREPAYMENT_CREDIT,
                CREDIT_PAY,
            SPEC_CLC_METHOD_ON_REC,
                ADVANCE,
                AGENTS_APPLY,
                SPEC_CLC_METHOD_ENTITY,
                CHECK_SEND,
        CABINET_CONNECT,
        CABINET_DISCONNECT,
        CABINET_RELOAD_GOODS,
        BUYERS_DATA,
        RECEIPT_SEND,
            RECEIPT_TO_SMS,
            EMAIL,
        ROOT_ID,
        INVALID_ID,
        PIRIT_TEST,
        //--
        //Специальные методы оплаты RB
        DISCOUNT_CHECK,
        DISCOUNT_POS,
        MARGIN_CHECK,
        MARGIN_POS,
        DEPARTMENT_SALE,

        DISCOUNT_POS_RET,
        MARGIN_CHECK_RET,
        MARGIN_POS_RET,
        DEPARTMENT_SALE_RET,
        //--
        // Режим маршрутки
        TRANSPORT_ROUTES,
        // COURIER
        COURIER_SALE,
        TRANSPORT_CASHLESS,
        CONNECT_KKT,
        CONNECT_BARCODE_SCANNER,
        CONNECT_SCALES,
        DREAMKAS_DISPLAY,
        //--
        UNKNOWN_MENU_ID
    };
    Q_ENUM(MENU_ID)

    /**
     * @brief The CustomRoles enum - роли пунктов меню.
     */
    enum CustomRoles : int
    {
        IdRole = Qt::UserRole + 1,
        NameRole,                       //!< Имя пункта меню
        VisibleRole,                    //!< Видимость пункта меню
        IconRole,                       //!< Адрес иконки пункта меню в ресурсах
        AppliedRole,                    //!< Состояние активности (применяемости)
        AppliedAvailableRole,           //!< Наличие признака активности (применяемости)
        IsHighlighted,                  //!< Состояние подсвечивания пункта
        IsFirstHighlighted,             //!< Состояние подсвечивания, как первого пункта
        IsLastHighlighted,              //!< Состояние подсвечивания, как последнего пункта
        IsRootItem
    };
    Q_ENUM(CustomRoles)

    static void declareQML() { qmlRegisterType<MenuModelTree>("CustomRolesEnum", 1, 0, "ModelEnum"); }

    QModelIndex index(int row, int column, const QModelIndex &parent) const override;
    QModelIndex parent(const QModelIndex &child) const override;
    int rowCount(const QModelIndex &parent) const override;
    int columnCount(const QModelIndex &parent) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QVariant headerData(int section, Qt::Orientation orientation, int role) const override;
    Qt::ItemFlags flags(const QModelIndex &index) const override;
    QHash<int, QByteArray> roleNames() const override;
    bool setData(const QModelIndex &index, const QVariant &value, int role) override;

    Q_INVOKABLE void setPopupFinished(int resKey, const QString &resString)
    {
        emit popupFinished(resKey, resString);
    }
    /**
     * @brief setPopupFinished закрытие popup добавления позиции
     * @param key клавиша пользователя
     * @param unitPrice цена товара
     * @param quantity количество товара в позиции
     * @param totalPrice итоговая стоимость позиции
     * @param isMarked флаг маркированного товара
     */
    Q_INVOKABLE void setPopupFinished(int key,
                                      const QString &unitPrice,
                                      const QString &quantity,
                                      const QString &totalPrice,
                                      const bool isMarked);
    /**
     * @brief setIsPrinterConnected запись флага подключения принтера
     * @param isPrinterConnected флаг подключения принтера
     */
    void setIsPrinterConnected(const bool isPrinterConnected);
    /**
     * @brief setIsPrinterRegistered запись флага регистрации принтера
     * @param isPrinterRegistered флаг регистрации принтера
     */
    void setIsPrinterRegistered(const bool isPrinterRegistered);
    /**
     * @brief setIsShiftOpened запись флага состояния смены
     * @param isShiftOpened флаг состояния смены
     */
    void setIsShiftOpened(const bool isShiftOpened);
    /**
     * @brief updatePrinterConnectionItems обновление дерева меню подключения принтера
     */
    void updatePrinterConnectionItems();
    /**
     * @brief send метод с требованием отправки чего-то(до этого во вью открывается экран отправки).
     *        После отпраки нужен сигнал sendFinished c текстом для вывода на дисплей
     * @param what что требуется отправить
     */
    Q_INVOKABLE void send(int what);
    /**
     * @brief isValid - Валидность индекса для вызова из QML.
     * @param index - Индекс.
     * @return Валидность.
     */
    Q_INVOKABLE inline bool isValid(const QModelIndex &index) const { return index.isValid(); }
    /**
     * @brief isRootItem тест корневого элемента меню
     * @param index индекс элемента меню
     * @return результат выполнения
     */
    Q_INVOKABLE bool isRootItem(const QModelIndex &index) const;
signals:
    /**
     * @brief menuSetVisibleInvItems - сигнал установки видимых и невидимых элементов.
     * @param visItems - видимые элементы.
     * @param invisItems - невидимые элементы.
     */
    void menuSetVisibleInvItems(const QList<MENU_ID> &visItems, const QList<MENU_ID> &invisItems);
    /**
     * @brief recievedFNCheckCompleted сигнал о прохождении проверки ФН выбранного маркированного товара
     * @result успешно ли пройдена проверка
     *  */
    void recievedFNCheckCompleted(const bool result);

    /**
     * @brief sendOISMCheckCompleted сигнал о прохождении проверки ОИСМ выбранного маркированного товара
     * @result успешно ли пройдена проверка
     *  */

    void recievedOISMCheckCompleted(const bool result);
    void logLevelListChanged();
    void popupListChanged();
    /**
     * @brief sendFinished  - signal to UI, that sending finished
     * @param displayStatus - staus of send ok|not ok
     * @param displayMess   - mess for display on result screen
     */
    void sendFinished(bool displayStatus, const QString &displayMess);
    /**
     * @brief sendLogs - signal to core for sending logs
     */
    void sendLogs();
    /**
     * @brief frontStartLoader - Сигнал вызов Loader'а.
     * @param msg - Сообщение на попапе.
     */
    void frontStartLoader(const QString &msg);
    /**
     * @brief onModelMenuStopLoader сигнал завершения Loader
     * @param success статус выполнения команды
     * @param msg сообщение пользователю
     */
    void frontStopLoader(bool success, const QString &msg);
    /**
     * @brief frontStopLoaderEasy сигнал завершения Loader
     */
    void frontStopLoaderEasy();
    /**
     * @brief onOpenPopup сигнал открытия popup добавления позиции в чек
     * @param popupType тип popup
     * @param mess сообщение пользователю
     * @param measure мерность товара в позиции
     * @param marked флаг маркированного товара
     * @param price цена товара
     * @param quantity количество товара
     * @param isFromCloud флаг добавления товара из "Облака Дримкас"
     * @param isService флаг типа товара - услуга
     */
    void openPopup(int popupType,
                   const QString &mess,
                   const QString &measure,
                   bool marked = false,
                   const QString &price = "",
                   const uint64_t quantity = 0,
                   const bool isFromCloud = false,
                   const bool isService = false);
    // to core
    void popupFinished(int resKey, QString resString);
    /**
     * @brief popupFinished сигнал закрытия popup добавления позиции в чек
     * @param key клавиша пользователя
     * @param unitPrice цена товара
     * @param quantity количество товара в позиции
     * @param total итоговая стоимость позиции
     * @param isMarkedфлаг маркированного товара
     */
    void popupFinished(int key,
                       const QString &unitPrice,
                       const QString &quantity,
                       const QString &total,
                       const bool isMarked);
public slots:
    /**
     * @brief onDreamkasDisplayConnectChanged слот изменения статуса подключения Дримкас Дисплей
     * @param isConnected статус подключения Дримкас Дисплей
     */
    void onDreamkasDisplayConnectChanged(const bool isConnected);
    /**
     * @brief onScalesConnected - слот обрабатывающий событие подключения весов
     */
     void onScalesConnected();

     /**
      * @brief onScalesConnected - слот обрабатывающий событие подключения весов
      */
      void onScalesDisconnected();
    /**
     * @brief onCoreSent - слот брабатывающий событие отправки из ядра(успешное или не очень)
     * @param status - удалось или нет отправить
     * @param message - сообщение с комментарием к результату
     */
    void onCoreSent(bool status, const QString &message);
    /**
     * @brief onModelShiftStateChanged слот изменения состояния смены
     * @param isShiftOpened состояние смены
     */
    void onModelShiftStateChanged(bool isShiftOpened);
    /**
     * @brief onModelPrinterConnectChanged слот изменения статуса подключения ККТ
     * @param isPrinterConnected статус подключения ККТ
     */
    void onModelPrinterConnectChanged(bool isPrinterConnected);
    /**
     * @brief onModelPrinterRegisteredChanged слот изменения статуса регистрации ККТ
     * @param isPrinterRegistered статус регистрации ККТ
     */
    void onModelPrinterRegisteredChanged(bool isPrinterRegistered);
    /**
     * @brief onModelItemsAppliedChanged - слот изменения флага видимости.
     * @param idList - набор уникальных идентификаторов элементов меню.
     * @param visible - флаг видимости.
     */
    void onModelItemsVisibleChanged(const QList<MENU_ID> &idList, const bool visible);
    /**
     * @brief onModelItemsAppliedChanged - слот изменения флага применения.
     * @param idList - набор уникальных идентификаторов элементов меню.
     * @param applied - флаг применения.
     */
    void onModelItemsAppliedChanged(const QList<MENU_ID> &idList, const bool applied);
    /**
     * @brief onOpenPopup слот открытия popup добавления позиции в чек
     * @param popupType тип popup
     * @param mess сообщение пользователю
     * @param measure мерность товара в позиции
     * @param marked флаг маркированного товара
     * @param price цена товара
     * @param quantity количество товара
     * @param isFromCloud флаг добавления товара из "Облака Дримкас"
     * @param isService флаг типа товара - услуга
     */
    inline void onOpenPopup(int popupType,
                            const QString &mess,
                            const QString &measure,
                            bool marked,
                            const QString &price = "",
                            const uint64_t quantity = 0,
                            const bool isFromCloud = false,
                            const bool isService = false) { emit openPopup(popupType, mess, measure, marked, price, quantity, isFromCloud, isService); }
    /**
     * @brief onOpenPopup open opoup window
     * @param popupType - type of popup
     * @param mess  - text for output on screen
     */
    void onOpenPopup(int popupType, const QString &mess, const QStringList &list);
private:
    /**
     * @brief initialize - Метод инициализации пунктов меню.
     */
    void initialize();
    /**
     * @brief updateShiftItems - Обновление видимости пунктов дерева меню, на основе флагов принтера и смены.
     */
    void updateShiftItems();

    struct MenuItemTree
    {
        explicit MenuItemTree() : m_childItems{}, m_parentItem(nullptr), m_pos(-1), m_name{"Root Item"} {}
        explicit MenuItemTree(MenuItemTree *parentItem,
                              const int pos,
                              const MENU_ID id = MENU_ID::UNKNOWN_MENU_ID,
                              const QString &name = "UNKNOWN_MENU_NAME",
                              const bool appliedAvailable = false,
                              const bool visible = true,
                              const bool applied = false);

        ~MenuItemTree();

        //    MenuItemTree(const MenuItemTree &other);
        //    MenuItemTree& operator=(const MenuItemTree &other);

        void appendChild(MenuItemTree *child);
        MenuItemTree *child(int row);
        int row();
        int childCount() { return m_childItems.size(); }

        QVector<MenuItemTree*>  m_childItems;       //! Контейнер указателей на дочерние пункты.
        MenuItemTree            *m_parentItem;      //! Указатель на родительский элемент.
        const int               m_pos;              //! Позиция относительно родительского.
        MENU_ID                 m_id;               //!< id пункта меню.
        QString		            m_name;             //!< наименование пункта меню.
        bool                    m_appliedAvailable; //!< Флаг наличия флага применения.
        bool                    m_visible;          //!< флаг видимости пункта меню.
        bool                    m_applied;          //!< флаг применения.
        bool                    m_isHighlighted {false};
        bool                    m_isFirstHighlighted {false};
        bool                    m_isLastHighlighted {false};
    };

    using MENU_ITEMS_TABLE = QMap<MENU_ID, MenuItemTree*>; //!< Для использования сокращенного.

    /**
     * @brief rowForItem - номер строки относительно родительского пункта меню.
     * @param item - пункт меню.
     * @return Номер строки.
     */
    int rowForItem(const MenuItemTree *item);
    /**
     * @brief indexForItem - Метод получения индекса пункта.
     * @param item - пункт меню.
     * @return Возвращает QModelIndex.
     */
    QModelIndex indexForItem(const MenuItemTree *item);

    /**
     * @brief removeItem (INVISIBLE) - метод удаления пункта из дерева меню, но сам пункт остается статически жив в контейнере.
     * @param item - пункт меню.
     */
    void removeItem(MenuItemTree *item); //! add remove bool?

    /**
     * @brief insertItem (VISIBLE) - метод вставки пункта в дерево меню, сделать видимым.
     * @param parentItem - парент item'a.
     * @param pos - позиция пункта в структуре.
     * @param item - пункт меню.
     */
    void insertItem(MenuItemTree *parentItem, MenuItemTree *item); //! add remove bool?

    /**
     * @brief getItem чтение элемента меню
     * @param id уникальный идентификатор элемента меню
     * @return Итератор пункта меню.
     */
    MENU_ITEMS_TABLE::iterator getItem(const MENU_ID id);
    /**
     * @brief delItem удаление элемента меню
     * @param id уникальный идентификатор элемента меню
     */
    void delItem(const MENU_ID id);
    /**
     * @brief addItem добавление элемента меню
     * @param id уникальный идентификатор элемента меню
     */
    void addItem(const MenuItemTree &item);
    /**
     * @brief setItemApplied установка флага применения
     * @param id уникальный идентификатор элемента меню
     * @param applied флаг применения
     */
    void setItemApplied(const MENU_ID id, const bool applied);
    QMutex m_menuMutex;                                                                             //! мьютекс модели меню
    bool m_isPrinterConnected;                                                                      //! флаг подключения принтера
    bool m_isPrinterRegistered;                                                                     //! флаг регистрации принтера
    bool m_isShiftOpened;                                                                           //! флаг состояния смены

    MenuItemTree *m_rootItem;

    QStringList popupList_{"hello", "World!"};

    MENU_ITEMS_TABLE            m_mapMenuItems; //!< QMap содержит "ID пункта меню(MENU_ID) - пункт меню(MenuItemTree*)"
    using ICONS_TABLE = QMap<MENU_ID, std::string>;
    static const ICONS_TABLE    m_mapIcons;     //!< QMap содержит "ID пункта меню(MENU_ID) - путь до картинки(QString)"
};

#endif // MENUMODELTREE_H
