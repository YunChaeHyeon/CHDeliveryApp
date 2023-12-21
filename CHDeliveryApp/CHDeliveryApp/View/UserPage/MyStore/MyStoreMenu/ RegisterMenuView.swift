//
//   RegisterMenuView.swift
//  CHDeliveryApp
//
//  Created by 윤채현 on 2023/10/17.
//

import SwiftUI



struct RegisterMenuView : View {
    @Environment(\.dismiss) private var dismiss
    var imageconversion : ImageConversion = ImageConversion()
    
    @ObservedObject var storeRegiVM : StoreViewModel
    var storeData : Store
    var isMenuEdit : Bool
    var isEdit : Bool
    var isRegister : Bool
    var menuIndex : Int
    
    
    @State var menuImage : Image?
    @State var selectedUIImage : UIImage?
    @State var showImagePicker = false
    
    @State var deleteButtonClicked = false
    
    func loadImage() {
        guard let selectedImage = selectedUIImage else { return }
        menuImage = Image(uiImage: selectedImage)
        
        let imageData = selectedUIImage!.jpegData(compressionQuality: 0.5)! as NSData
        storeRegiVM.menuImage = imageData
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                
                //VStack{
                    //메뉴 사진 추가
                    
                        Button(action: {
                            showImagePicker.toggle()
                        }, label: {
                            if let image = menuImage{
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .ignoresSafeArea(edges: .top)
                                    .frame(height: 170)
                                    .clipped()
                                    .padding(.bottom , 20)
                            }
                            else{
                                if(isEdit){
                                    menuImage?
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .ignoresSafeArea(edges: .top)
                                        .frame(height: 170)
                                        .clipped()
                                        .padding(.bottom , 20)
                                }else{
                                    VStack{
                                        Text("메뉴 사진 등록").foregroundColor(Color.black)
                                        Image(systemName: "plus.app.fill")
                                            .foregroundColor(Color.black)
                                            .font(.system(size: 50))
                                    }
                                .padding(.vertical, 20)
                                }

                            }


                        })
                        .onAppear{
                            //메뉴 이미지 초기화
                            if(isEdit){
                                menuImage = imageconversion.getImage(_image: storeData.menus[menuIndex].menuImage!)
                            }
                            
                        }
                            .sheet(isPresented: $showImagePicker, onDismiss: {
                                loadImage()
                                //imageChangeWhether = true
                            }) {
                                ImagePicker(image: $selectedUIImage)
                            }
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets())
//==============================================================================================
                    
                // 메뉴 이름
                    HStack{
                        TextField("메뉴 이름 입력", text: $storeRegiVM.menuName)
                            .frame(width: 100)
                            .textFieldStyle(PlainTextFieldStyle())
                            .fixedSize(horizontal: true, vertical: false)
                            .multilineTextAlignment(.center)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                            .background(borderStyleView())
                            .padding(.bottom , 10)
                        Spacer()
                    }

                    .padding(.horizontal , 20)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)


                //메뉴 기본 가격
                    HStack{
                        Text("기본가격 ").font(.system(size:20 , weight: .bold))
                        Spacer()
                        TextField("메뉴 가격 입력", value: $storeRegiVM.menuDefaultPrice , format: .number)
                            .frame(width: 100)
                            .textFieldStyle(PlainTextFieldStyle())
                            .fixedSize(horizontal: true, vertical: false)
                            .multilineTextAlignment(.center)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                            .background(borderStyleView())
                    }.padding(.horizontal , 20)
                    //Divider().background(Color.black)
                //}//VStack
                    .onDisappear{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                storeRegiVM.menuRequireds.removeAll()
                                storeRegiVM.menuOptions.removeAll()
                        }

                    }
                    .onAppear{
                        //isEdit 루트 -> (내 가게 수정) -> 리스트 선택 -> 수정할 가게 정보,메뉴 뜸
                        if(isEdit){
                            storeRegiVM.menuName = storeData.menus[menuIndex].menuName
                            storeRegiVM.menuDefaultPrice = storeData.menus[menuIndex].menuDefaultPrice
                                //Required 초기화(init)
                                if(storeData.menus[menuIndex].menuRequired.count > 0){
                                    for count in 1...storeData.menus[menuIndex].menuRequired.count {
                                        print("Add MenuRequired()")
                                        storeRegiVM.menuRequireds.append( MenuRequired() )
                                        storeRegiVM.menuRequireds[count-1].menuRequitedTilte = storeRegiVM.menus[menuIndex].menuRequired[count-1].menuRequitedTilte
                                        
                                        //RequiredList 초기화
                                        if(storeRegiVM.menus[menuIndex].menuRequired[count-1].menuRequiredList.count > 0){
                                            for listCount in 1...storeRegiVM.menus[menuIndex].menuRequired[count-1].menuRequiredList.count {
                                                
                                                //리스트 추가
                                                storeRegiVM.menuRequireds[count-1].menuRequiredList.append( MenuRequiredList() )
                                                
                                                //리스트 제목 초기화
                                                storeRegiVM.menuRequireds[count-1].menuRequiredList[listCount-1].menuRequiredTitle =
                                                storeRegiVM.menus[menuIndex].menuRequired[count-1].menuRequiredList[listCount-1].menuRequiredTitle
                                                
                                                //리스트 가격 초기화
                                                storeRegiVM.menuRequireds[count-1].menuRequiredList[listCount-1].menuPrice =
                                                storeRegiVM.menus[menuIndex].menuRequired[count-1].menuRequiredList[listCount-1].menuPrice
                                            }
                                        }
                                        
                                    }
                                }
                                
                                //Option 초기화(init)
                                if(storeData.menus[menuIndex].menuOptions.count > 0){
                                    for count in 1...storeData.menus[menuIndex].menuOptions.count {
                                        storeRegiVM.menuOptions.append( MenuOption() )
                                        storeRegiVM.menuOptions[count-1].menuOptionsTilte = storeRegiVM.menus[menuIndex].menuOptions[count-1].menuOptionsTilte
                                        
                                        //OptionList 초기화
                                        if(storeRegiVM.menus[menuIndex].menuOptions[count-1].menuOptionList.count > 0){
                                            for listCount in 1...storeRegiVM.menus[menuIndex].menuOptions[count-1].menuOptionList.count {
                                                
                                                //리스트 추가
                                                storeRegiVM.menuOptions[count-1].menuOptionList.append( MenuOptionList() )
                                                
                                                //리스트 제목 초기화
                                                storeRegiVM.menuOptions[count-1].menuOptionList[listCount-1].menuOptionTitle =
                                                storeRegiVM.menus[menuIndex].menuOptions[count-1].menuOptionList[listCount-1].menuOptionTitle
                                                
                                                //리스트 가격 초기화
                                                storeRegiVM.menuOptions[count-1].menuOptionList[listCount-1].menuPrice =
                                                storeRegiVM.menus[menuIndex].menuOptions[count-1].menuOptionList[listCount-1].menuPrice
                                            }
                                        }
                                    }
                                }
                            
                            
                        }
                    }
                .navigationBarBackButtonHidden(true)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarTitle("")
                .toolbar {
                    
                    // 2
                    ToolbarItem(placement: .navigationBarLeading) {
                        HStack{
                            Button {
                                dismiss()

                            } label: {
                                // 4
                                HStack {
                                    Image(systemName: "chevron.backward").foregroundColor(Color.black)
                                    Text("메뉴 등록").foregroundColor(Color.black)

                                }
                             }
                        }
                   }//ToolbarItem.
                }//toolbar
                .navigationBarBackground({
                    Color.white
                })
//===============================================================================================
                    VStack{

                        //****
                        ForEach(storeRegiVM.menuRequireds.indices , id:\.self){ index in
                            AddMenuRequiredView(storeRegiVM : storeRegiVM , Index: index , isEdit: isMenuEdit , menuIndex: menuIndex)
                            Divider().background(Color.mint)

                        }

                    }


                //필수 추가
                    Button(action: {
                        storeRegiVM.objectWillChange.send()
                        storeRegiVM.menuRequireds.append( MenuRequired() )
                        if(isEdit){
                            storeRegiVM.addRequ(old: storeRegiVM.menus[menuIndex])
                        }
                    }, label: {
                        VStack{
                            Text("필수 사항 등록").foregroundColor(Color.black)
                            Image(systemName: "plus.app.fill")
                                .foregroundColor(Color.black)
                                .font(.system(size: 50))
                        }

                    }).padding(20)

//================================================================================================
                    Divider().background(Color.black)
                    VStack{
                        ForEach(storeRegiVM.menuOptions.indices , id:\.self){ index in
                            AddMenuOptionsView(storeRegiVM : storeRegiVM , Index: index , isEdit : isEdit , menuIndex : menuIndex )
                                Divider().background(Color.mint)
                        }
                    }

                //선택 추가
                    Button(action: {
                        
                        storeRegiVM.menuOptions.append(MenuOption())
                        if(isEdit){
                            storeRegiVM.addOption(old: storeRegiVM.menus[menuIndex])
                        }
                        for (index, value) in storeRegiVM.menuOptions.enumerated() {
                            print((index, value))
                        }
                    }, label: {
                        VStack{
                            Text("선택 사항 등록").foregroundColor(Color.black)
                            Image(systemName: "plus.app.fill")
                                .foregroundColor(Color.black)
                                .font(.system(size: 50))
                        }

                    }).padding(20)

                    
            }.listStyle(PlainListStyle())//List
                .padding(.bottom , 70)
            
            if(isMenuEdit){
                if(!isEdit){
                    //
                        MenuAddButton(storeRegiVM: storeRegiVM , menu: Menu(), isMenuEdit:
                                        isMenuEdit)

                }else{
                    //가게수정 -> 메뉴 수정
                        MenuAddButton(storeRegiVM: storeRegiVM , menu: storeRegiVM.menus[menuIndex], isMenuEdit:
                                        isMenuEdit)
                }
                 
            }else{
                //가게수정 -> 메뉴 등록
                //가게 등록 -> 메뉴 등로
                    MenuAddButton(storeRegiVM: storeRegiVM , menu: Menu(), isMenuEdit: isMenuEdit)

            }
            
        }//ZStack
        .onTapGesture {
            hideKeyboard()
        }
        .onAppear(){
            if(isMenuEdit){
                if(isEdit){
                    storeRegiVM.menuImage = storeData.menus[menuIndex].menuImage
                }else{
                    
                }
                
            }else{
                storeRegiVM.menuImage = nil
                storeRegiVM.menuName = ""
                storeRegiVM.menuDefaultPrice = 0
            }
            

        }
    }
}

struct MenuAddButton : View {
    @ObservedObject var storeRegiVM: StoreViewModel
    @Environment(\.dismiss) private var dismiss
    var menu : Menu
    var isMenuEdit : Bool
    
    var body: some View {

        HStack{

                Button(action: {
                    
                    if(isMenuEdit){
                        storeRegiVM.editMenu(old: menu)
                    }else{
                        storeRegiVM.addMenu()
                        print("addMenu")
                        print("\(storeRegiVM.menus.count)")
                        
                    }
                    
                    //dismiss()
                }, label: {
                    HStack{
                        if(isMenuEdit){
                            Text("메뉴 수정하기")
                        }else{
                            Text("메뉴 등록하기")
                        }
                        
                    }
                    .font(.system(size:20 , weight: .bold))
                    .foregroundColor(Color.white)
                    .frame(width: 250, height: 50)
                }).background(Color.black)
                    .cornerRadius(10)
                    .padding(10)

        } //HStack
        .frame(maxWidth: .infinity)
    }
}

struct AddMenuRequiredView : View {
    @ObservedObject var storeRegiVM: StoreViewModel
    var Index : Int
    var isEdit : Bool
    var menuIndex : Int
    @FocusState var focused: Bool
    
    var body: some View {
        
        VStack {
            HStack{
                Spacer()
                
                Button(action: {
                        storeRegiVM.objectWillChange.send()
                        storeRegiVM.menuRequireds.remove(at: Index)
                    if(isEdit){
                        storeRegiVM.delRequ(old : storeRegiVM.menus[menuIndex] , Index : Index)
                    }
                    
                }, label: {Image(systemName: "trash.fill")
                        .foregroundColor(Color.red)
                        .font(.system(size: 20))
                })
                
            }.padding(.trailing, 20)
            
            HStack{
                
                TextField("필수 메뉴 제목", text: Binding(get:  {  self.Index < self.storeRegiVM.menuRequireds.count ? self.storeRegiVM.menuRequireds[Index].menuRequitedTilte : "" } 
                                                      ,set : {
                                                storeRegiVM.objectWillChange.send()
                                                storeRegiVM.menuRequireds[Index].menuRequitedTilte = $0
                                                }))
                    .frame(width: 100)
                    .textFieldStyle(PlainTextFieldStyle())
                    .fixedSize(horizontal: true, vertical: false)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 16)
                    .background(borderStyleView())
                    .padding(.bottom , 10)
                    //.focused($focused)

                
                    Spacer()
                    
            }.padding(.horizontal,10) //HStack
            
            //=====================================================================
            
                if(Index < storeRegiVM.menuRequireds.count){
                    VStack{
                        ForEach(storeRegiVM.menuRequireds[self.Index].menuRequiredList.indices , id:\.self){ listindex in

                            AddMenuRequiredListView(storeRegiVM : storeRegiVM , Index2: Index , listIndex: listindex , isEdit: isEdit , menuIndex: menuIndex)
                        }
                    }

                }

        
            //=====================================================================
            Button(action: {
                storeRegiVM.objectWillChange.send()
                storeRegiVM.menuRequireds[self.Index].menuRequiredList.append(MenuRequiredList())
                
                if(isEdit){
                    storeRegiVM.addRequList(old: storeRegiVM.menus[menuIndex], Index: Index)
                }

            }, label: {
                VStack{
                    Text("필수 목록 등록").foregroundColor(Color.black)
                    Image(systemName: "plus.app.fill")
                        .foregroundColor(Color.mint)
                        .font(.system(size: 30))
                }

            }).padding(20)
        }//VStack
    }
}


struct AddMenuRequiredListView : View {
    @ObservedObject var storeRegiVM: StoreViewModel
    var Index2 : Int
    var listIndex : Int
    var isEdit : Bool
    var menuIndex : Int
    
    var body: some View {
        HStack{

                TextField("목록 입력", text:  Binding(get:  {
                    self.listIndex < self.storeRegiVM.menuRequireds[Index2].menuRequiredList.count ?
                    self.storeRegiVM.menuRequireds[Index2].menuRequiredList[listIndex].menuRequiredTitle : ""

                }
                                                  ,set : {
                    storeRegiVM.objectWillChange.send()
                    print("set : \(storeRegiVM.menuRequireds[Index2].menuRequiredList[listIndex].menuRequiredTitle)")
                    storeRegiVM.menuRequireds[Index2].menuRequiredList[listIndex].menuRequiredTitle = $0}))
                        .frame(width: 80)
                        .textFieldStyle(PlainTextFieldStyle())
                        .fixedSize(horizontal: true, vertical: false)
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 16)
                        .background(borderStyleView())
                        .padding(.bottom , 10)
                        .padding(.horizontal,30)

                Spacer()

            TextField("가격 입력", value : Binding(get: {
                self.listIndex < self.storeRegiVM.menuRequireds[Index2].menuRequiredList.count ?
                self.storeRegiVM.menuRequireds[Index2].menuRequiredList[listIndex].menuPrice : 0
            } , set: {
                storeRegiVM.objectWillChange.send()
                self.storeRegiVM.menuRequireds[Index2].menuRequiredList[listIndex].menuPrice = $0}),  format: .number)
                    .frame(width: 80)
                    .textFieldStyle(PlainTextFieldStyle())
                    .fixedSize(horizontal: true, vertical: false)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 16)
                    .background(borderStyleView())
                    .padding(.bottom , 10)
                    .padding(.horizontal,30)
                    .keyboardType(.numberPad)

            
            Button(action: {
                storeRegiVM.objectWillChange.send()
                storeRegiVM.menuRequireds[Index2].menuRequiredList.remove(at: listIndex)
                if(isEdit){
                    storeRegiVM.delRequList(old: storeRegiVM.menus[menuIndex], Index: Index2, ListIndex: listIndex)
                }
            }, label: {
                VStack{
                    
                    Image(systemName: "delete.left.fill")
                        .foregroundColor(Color.red)
                        .font(.system(size: 20))
                }

            })

        }.padding(.trailing, 20)
        
    }
}

struct AddMenuOptionsView : View {
    @ObservedObject var storeRegiVM: StoreViewModel
    var Index : Int
    var isEdit : Bool
    var menuIndex : Int
    
    @State var title : String = ""
    @FocusState var focused: Bool
    
    var body: some View {
        VStack {
            HStack{
                Spacer()
                Button(action: {
                    storeRegiVM.menuOptions.remove(at: Index)
                    if(isEdit){
                        storeRegiVM.delOption(old : storeRegiVM.menus[menuIndex] , Index : Index)
                    }
                }, label: {Image(systemName: "trash.fill")
                        .foregroundColor(Color.red)
                        .font(.system(size: 20))
                })

            }.padding(.trailing, 20)
            
            HStack{
                    
                TextField("선택 메뉴 제목", text: Binding(get:  {  self.Index < self.storeRegiVM.menuOptions.count ? self.storeRegiVM.menuOptions[Index].menuOptionsTilte : "" } ,set : {
                    storeRegiVM.objectWillChange.send()
                    storeRegiVM.menuOptions[Index].menuOptionsTilte = $0}))
                        .frame(width: 100)
                        .textFieldStyle(PlainTextFieldStyle())
                        .fixedSize(horizontal: true, vertical: false)
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 16)
                        .background(borderStyleView())
                        .padding(.bottom , 10)
                        .focused($focused)
    
                    Spacer()
                    
            }.padding(.horizontal,10) //HStack
            
            //=====================================================================
            if(Index < storeRegiVM.menuOptions.count){
                ForEach(storeRegiVM.menuOptions[Index].menuOptionList.indices , id:\.self){ listindex in
                    AddMenuOptionListView(storeRegiVM : storeRegiVM , Index2: self.Index , listIndex: listindex)

                }
            }
            
//            =====================================================================
            Button(action: {
                storeRegiVM.objectWillChange.send()
                storeRegiVM.menuOptions[Index].menuOptionList.append(MenuOptionList())
                
                if(isEdit){
                    
                }
            }, label: {
                VStack{
                    Text("선택 목록 등록").foregroundColor(Color.black)
                    Image(systemName: "plus.app.fill")
                        .foregroundColor(Color.mint)
                        .font(.system(size: 30))
                }

            }).padding(20)
        }//VStack
    }
}

struct AddMenuOptionListView : View {
    @ObservedObject var storeRegiVM: StoreViewModel
    var Index2 : Int
    var listIndex : Int
    @State var title : String = ""
    @State var price : String = ""

    var body: some View {
        HStack{
            //ios 13 버전
//            TextField("목록 입력", text:  Binding(get:  {
//                self.Index2 < self.storeRegiVM.menuOptions.count && self.listIndex < self.storeRegiVM.menuOptions[Index2].menuOptionList.count && self.Index2 < self.storeRegiVM.menuOptions[Index2].menuOptionList.count ?
//                self.storeRegiVM.menuOptions[Index2].menuOptionList[listIndex].menuOptionTitle : ""
//
//            }
//                                              ,set : {
//                storeRegiVM.objectWillChange.send()
//                storeRegiVM.menuOptions[Index2].menuOptionList[listIndex].menuOptionTitle = $0}))
            TextField("목록 입력", text:  Binding(get:  {self.listIndex < self.storeRegiVM.menuOptions[Index2].menuOptionList.count ?
                self.storeRegiVM.menuOptions[Index2].menuOptionList[listIndex].menuOptionTitle : ""

            }
                                              ,set : {
                storeRegiVM.objectWillChange.send()
                storeRegiVM.menuOptions[Index2].menuOptionList[listIndex].menuOptionTitle = $0}))
                    .frame(width: 80)
                    .textFieldStyle(PlainTextFieldStyle())
                    .fixedSize(horizontal: true, vertical: false)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 16)
                    .background(borderStyleView())
                    .padding(.bottom , 10)
                    .padding(.horizontal,30)
            Spacer()

            TextField("가격 입력", value : Binding(get: {self.listIndex < self.storeRegiVM.menuOptions[Index2].menuOptionList.count ?
                self.storeRegiVM.menuOptions[Index2].menuOptionList[listIndex].menuPrice : 0
            } , set: {self.storeRegiVM.menuOptions[Index2].menuOptionList[listIndex].menuPrice = $0}), formatter: NumberFormatter())
                    .frame(width: 80)
                    .textFieldStyle(PlainTextFieldStyle())
                    .fixedSize(horizontal: true, vertical: false)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 16)
                    .background(borderStyleView())
                    .padding(.bottom , 10)
                    .padding(.horizontal,30)
                    .keyboardType(.numberPad)


            Button(action: {
                storeRegiVM.objectWillChange.send()
                storeRegiVM.menuOptions[Index2].menuOptionList.remove(at: listIndex)
            }, label: {Image(systemName: "delete.left.fill")
                    .foregroundColor(Color.red)
                    .font(.system(size: 20))
            })


        }.padding(.trailing, 20)
    }
}

